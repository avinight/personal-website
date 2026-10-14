module Logo exposing (Model, Msg, init, setDark, subscriptions, update, view)

{-| The animated logo on the home page: a mosaic of small triangular shards in
the site's terracotta and teal palette. The shards fly between pictures of
things Frederick likes, one after another. Shards scatter away from the
pointer, the cycle pauses while it's over the logo, and a click skips to the
next picture.

Pictures are drawn as text below. Each character is one grid cell:

    █  a full cell (two shards)
    ◤ ◥ ◢ ◣  a half cell (one shard), filled on the side the symbol shows
    .  empty

-}

import Browser.Events
import Html exposing (Html)
import Html.Attributes as HA
import Html.Events
import Html.Lazy
import Json.Decode as Decode
import Math.Vector2 exposing (Vec2, vec2)
import Math.Vector3 exposing (Vec3)
import Math.Vector4 exposing (Vec4, vec4)
import Palette
import WebGL exposing (Mesh, Shader)



-- PICTURES


type alias Pose =
    { x : Float
    , y : Float
    , rot : Float
    , scale : Float
    }


type alias Picture =
    { label : String
    , poses : List Pose
    }


pictures : List Picture
pictures =
    [ fromArt "fried rice"
        [ ".....◢◤."
        , "....◢◤.."
        , ".◢███◣.."
        , "████████"
        , "◥██████◤"
        , ".◥████◤."
        , "..◥██◤.."
        ]
    , fromArt "climbing"
        [ "...◢◣....."
        , "..◢██◣◢◣.."
        , ".◢██████◣."
        , "◢████████◣"
        ]
    , fromArt "lifting"
        [ ".◢█...█◣."
        , "███...███"
        , "█████████"
        , "███...███"
        , ".◥█...█◤."
        ]
    , fromArt "piano"
        [ "...██◣.."
        , "...█◥█◣."
        , "...█.◥█."
        , "...█..◤."
        , "...█...."
        , ".◢██...."
        , "████...."
        , "◥██◤...."
        ]
    , fromArt "matcha"
        [ "◢◤.◢◤.."
        , "◥◣.◥◣.."
        , "█████.."
        , "██████◣"
        , "█████.█"
        , "██████◤"
        , "◥███◤.."
        ]
    ]


{-| Shards are numbered in reading order, so a change of picture sweeps from
the top of the logo to the bottom.
-}
fromArt : String -> List String -> Picture
fromArt label rows =
    let
        cells =
            List.map String.toList rows

        width =
            cells |> List.map List.length |> List.maximum |> Maybe.withDefault 0

        cx =
            toFloat (width - 1) / 2

        cy =
            toFloat (List.length rows - 1) / 2

        shards r c char =
            List.map
                (\rot -> { x = toFloat c - cx, y = toFloat r - cy, rot = rot, scale = 1 })
                (rotations char)
    in
    { label = label
    , poses =
        cells
            |> List.indexedMap (\r row -> List.concat (List.indexedMap (shards r) row))
            |> List.concat
    }


{-| The shard is drawn as ◤; the other half cells are it turned clockwise.
-}
rotations : Char -> List Float
rotations char =
    case char of
        '█' ->
            [ 0, 180 ]

        '◤' ->
            [ 0 ]

        '◥' ->
            [ 90 ]

        '◢' ->
            [ 180 ]

        '◣' ->
            [ 270 ]

        _ ->
            []


pictureCount : Int
pictureCount =
    List.length pictures


pictureAt : Int -> Picture
pictureAt index =
    pictures
        |> List.drop (modBy pictureCount index)
        |> List.head
        |> Maybe.withDefault { label = "", poses = [] }


shardCount : Int
shardCount =
    pictures
        |> List.map (.poses >> List.length)
        |> List.maximum
        |> Maybe.withDefault 0



-- TIMING (milliseconds)


flight : Float
flight =
    850


stagger : Float
stagger =
    14


settled : Float
settled =
    flight + stagger * toFloat (shardCount - 1)


hold : Float
hold =
    2600


{-| How long the colours take to follow a theme switch.
-}
fade : Float
fade =
    400



-- MODEL


{-| `flightMesh` holds every shard's flight from `from` to `to`, so a frame
only tells the GPU how far along it is. `shade` fades from the light
palette (0) to the dark one (1) when the theme switches.
-}
type alias Model =
    { index : Int
    , from : List Pose
    , to : List Pose
    , flightMesh : Mesh Vertex
    , elapsed : Float
    , reducedMotion : Bool
    , pointer : Maybe ( Float, Float )
    , cursor : ( Float, Float )
    , presence : Float
    , dark : Bool
    , shade : Float
    }


{-| Shards start hidden on a spiral around the logo and assemble into the
first picture.
-}
init : { reducedMotion : Bool, dark : Bool } -> Model
init { reducedMotion, dark } =
    let
        target =
            posesFor 0 scattered

        ( from, elapsed ) =
            if reducedMotion then
                ( target, settled )

            else
                ( scattered, 0 )
    in
    { index = 0
    , from = from
    , to = target
    , flightMesh = meshOf from target
    , elapsed = elapsed
    , reducedMotion = reducedMotion
    , pointer = Nothing
    , cursor = ( 0, 0 )
    , presence = 0
    , dark = dark
    , shade = shadeOf dark
    }


{-| Fades the shards to the new theme's colours, or switches straight away
when `fading` is off.
-}
setDark : Bool -> Bool -> Model -> Model
setDark fading dark model =
    if fading && not model.reducedMotion then
        { model | dark = dark }

    else
        { model | dark = dark, shade = shadeOf dark }


shadeOf : Bool -> Float
shadeOf dark =
    if dark then
        1

    else
        0


scattered : List Pose
scattered =
    List.range 0 (shardCount - 1)
        |> List.map
            (\i ->
                let
                    angle =
                        toFloat i * 2.39996

                    radius =
                        3.5 + toFloat (modBy 3 i)
                in
                { x = radius * cos angle
                , y = radius * sin angle
                , rot = toFloat (i * 47)
                , scale = 0
                }
            )


{-| Where each shard goes for a picture, given where it is now. Shards the
picture doesn't need shrink away in place.
-}
posesFor : Int -> List Pose -> List Pose
posesFor index current =
    let
        slots =
            (pictureAt index).poses

        padded =
            List.map Just slots ++ List.repeat (shardCount - List.length slots) Nothing
    in
    List.map2 settle current padded


settle : Pose -> Maybe Pose -> Pose
settle now slot =
    case slot of
        Just pose ->
            { pose | rot = now.rot + shortestTurn now.rot pose.rot }

        Nothing ->
            { now | rot = now.rot + 90, scale = 0 }


{-| The turn from angle `a` to angle `b`, between -180 and 180 degrees.
-}
shortestTurn : Float -> Float -> Float
shortestTurn a b =
    let
        d =
            b - a
    in
    d - 360 * toFloat (floor ((d + 180) / 360))



-- UPDATE


type Msg
    = Frame Float
    | Next
    | PointerMoved Float Float Float Float
    | PointerLeft


update : Msg -> Model -> Model
update msg model =
    case msg of
        Frame rawDelta ->
            let
                -- Long gaps (a background tab) shouldn't skip the animation.
                delta =
                    min rawDelta 50

                elapsed =
                    case model.pointer of
                        -- Hold the current picture while someone plays with it.
                        Just _ ->
                            min (model.elapsed + delta) settled

                        Nothing ->
                            model.elapsed + delta

                follow =
                    1 - e ^ (-delta / 70)

                ( cx, cy ) =
                    model.cursor

                ( tx, ty, wanted ) =
                    case model.pointer of
                        Just ( px, py ) ->
                            ( px, py, 1 )

                        Nothing ->
                            ( cx, cy, 0 )

                moved =
                    { model
                        | elapsed = elapsed
                        , cursor = ( lerp cx tx follow, lerp cy ty follow )
                        , presence = lerp model.presence wanted (1 - e ^ (-delta / 160))
                        , shade = towards (shadeOf model.dark) (delta / fade) model.shade
                    }
            in
            if elapsed >= settled + hold then
                advance moved

            else
                moved

        Next ->
            advance model

        PointerMoved offsetX offsetY width height ->
            if width <= 0 || height <= 0 then
                model

            else
                let
                    point =
                        ( offsetX / width * 10 - 5, offsetY / height * 10 - 5 )
                in
                { model
                    | pointer = Just point
                    , cursor =
                        -- Start from the pointer when it first arrives.
                        if model.presence < 0.01 then
                            point

                        else
                            model.cursor
                }

        PointerLeft ->
            { model | pointer = Nothing }


advance : Model -> Model
advance model =
    let
        current =
            currentPoses model

        next =
            modBy pictureCount (model.index + 1)

        target =
            posesFor next current
    in
    if model.reducedMotion then
        { model | index = next, from = target, to = target, flightMesh = meshOf target target, elapsed = settled }

    else
        { model | index = next, from = current, to = target, flightMesh = meshOf current target, elapsed = 0 }


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.reducedMotion then
        Sub.none

    else
        Browser.Events.onAnimationFrameDelta Frame



-- ANIMATION


currentPoses : Model -> List Pose
currentPoses model =
    List.map3 (shardAt model.elapsed)
        (List.range 0 (shardCount - 1))
        model.from
        model.to


shardAt : Float -> Int -> Pose -> Pose -> Pose
shardAt elapsed i a b =
    let
        t =
            clamp 0 1 ((elapsed - stagger * toFloat i) / flight)

        move =
            easeInOutBack t

        grow =
            easeInOutCubic t
    in
    { x = lerp a.x b.x move
    , y = lerp a.y b.y move
    , rot = lerp a.rot b.rot move
    , scale = lerp a.scale b.scale grow
    }


lerp : Float -> Float -> Float -> Float
lerp a b t =
    a + (b - a) * t


towards : Float -> Float -> Float -> Float
towards target step value =
    if value < target then
        min target (value + step)

    else
        max target (value - step)


easeInOutCubic : Float -> Float
easeInOutCubic t =
    if t < 0.5 then
        4 * t * t * t

    else
        1 - ((-2 * t + 2) ^ 3) / 2


{-| Pulls back slightly before leaving and overshoots a little on arrival.
The vertex shader below eases the same way.
-}
easeInOutBack : Float -> Float
easeInOutBack t =
    let
        c =
            1.2 * 1.525
    in
    if t < 0.5 then
        ((2 * t) ^ 2 * ((c + 1) * 2 * t - c)) / 2

    else
        ((2 * t - 2) ^ 2 * ((c + 1) * (t * 2 - 2) + c) + 2) / 2



-- VIEW


{-| `pixels` is how many device pixels wide the drawing is.
-}
view : Int -> Model -> Html Msg
view pixels model =
    Html.button
        [ HA.class "logo"
        , HA.type_ "button"
        , HA.attribute "aria-label"
            ("Logo showing " ++ (pictureAt model.index).label ++ ". Press for the next picture.")
        , Html.Events.onClick Next
        , Html.Events.on "pointermove" pointerDecoder
        , Html.Events.on "pointerleave" (Decode.succeed PointerLeft)
        ]
        [ if isStill model then
            Html.Lazy.lazy7 viewArt pixels model.flightMesh settled 0 0 0 model.shade

          else
            let
                ( cx, cy ) =
                    model.cursor
            in
            Html.Lazy.lazy7 viewArt pixels model.flightMesh model.elapsed cx cy model.presence model.shade
        ]


{-| Between pictures, with nobody pointing at it and the colours settled,
the logo doesn't move, so it is drawn once and left alone until the next
picture.
-}
isStill : Model -> Bool
isStill model =
    model.elapsed >= settled && model.presence < 0.0005 && model.shade == shadeOf model.dark


{-| The drawing ignores the pointer (see logo.css), so offsets are measured
against the button, which is exactly the size of the logo.
-}
pointerDecoder : Decode.Decoder Msg
pointerDecoder =
    Decode.map4 PointerMoved
        (Decode.field "offsetX" Decode.float)
        (Decode.field "offsetY" Decode.float)
        (Decode.at [ "currentTarget", "clientWidth" ] Decode.float)
        (Decode.at [ "currentTarget", "clientHeight" ] Decode.float)


{-| The canvas is twice the logo's size, centred on it, so shards flying in
from the spiral or pushed by the pointer can leave the logo's box. It spans
-10 to 10 in grid cells.
-}
viewArt : Int -> Mesh Vertex -> Float -> Float -> Float -> Float -> Float -> Html msg
viewArt pixels flightMesh elapsed cx cy presence shade =
    let
        palette =
            Palette.mix (shade * shade * (3 - 2 * shade)) Palette.light Palette.dark
    in
    WebGL.toHtmlWith
        [ WebGL.alpha True, WebGL.antialias, WebGL.clearColor 0 0 0 0 ]
        [ HA.class "logo-art"
        , HA.attribute "aria-hidden" "true"
        , HA.width pixels
        , HA.height pixels
        ]
        [ WebGL.entity vertexShader
            fragmentShader
            flightMesh
            { elapsed = elapsed
            , flight = flight
            , cursor = vec2 cx cy
            , presence = presence
            , tone0 = palette.primary
            , tone1 = palette.accent
            , tone2 = palette.primaryStrong
            , tone3 = palette.accentStrong
            }
        ]



-- SHARDS


{-| Every shard is one triangle, drawn as ◤ at its full size. `start` and
`finish` are where it flies from and to, as x, y, rotation and scale; `delay`
is when it sets off; `tone` picks one of four colours.
-}
type alias Vertex =
    { start : Vec4
    , finish : Vec4
    , corner : Vec2
    , delay : Float
    , tone : Float
    }


meshOf : List Pose -> List Pose -> Mesh Vertex
meshOf from to =
    let
        poseVec pose =
            vec4 pose.x pose.y pose.rot pose.scale

        shard i a b =
            let
                corner x y =
                    { start = poseVec a
                    , finish = poseVec b
                    , corner = vec2 x y
                    , delay = stagger * toFloat i
                    , tone = toFloat (modBy 4 (i * 7 // 3))
                    }
            in
            ( corner -0.47 -0.47, corner 0.47 -0.47, corner -0.47 0.47 )
    in
    WebGL.triangles (List.map3 shard (List.range 0 (shardCount - 1)) from to)


type alias Uniforms =
    { elapsed : Float
    , flight : Float
    , cursor : Vec2
    , presence : Float
    , tone0 : Vec3
    , tone1 : Vec3
    , tone2 : Vec3
    , tone3 : Vec3
    }


{-| Flies each shard along its path the way `shardAt` does, then pushes
shards near the pointer outward and tilts them, more strongly the closer
they are. Rotations are in degrees, clockwise, with y pointing down.
-}
vertexShader : Shader Vertex Uniforms { colour : Vec3 }
vertexShader =
    [glsl|
        attribute vec4 start;
        attribute vec4 finish;
        attribute vec2 corner;
        attribute float delay;
        attribute float tone;
        uniform float elapsed;
        uniform float flight;
        uniform vec2 cursor;
        uniform float presence;
        uniform vec3 tone0;
        uniform vec3 tone1;
        uniform vec3 tone2;
        uniform vec3 tone3;
        varying vec3 colour;

        float easeInOutCubic(float t) {
            if (t < 0.5) {
                return 4.0 * t * t * t;
            }
            float u = 2.0 - 2.0 * t;
            return 1.0 - u * u * u / 2.0;
        }

        float easeInOutBack(float t) {
            float c = 1.2 * 1.525;
            if (t < 0.5) {
                float u = 2.0 * t;
                return u * u * ((c + 1.0) * u - c) / 2.0;
            }
            float u = 2.0 * t - 2.0;
            return (u * u * ((c + 1.0) * u + c) + 2.0) / 2.0;
        }

        void main() {
            float t = clamp((elapsed - delay) / flight, 0.0, 1.0);
            float move = easeInOutBack(t);
            vec2 centre = start.xy + (finish.xy - start.xy) * move;
            float rot = start.z + (finish.z - start.z) * move;
            float scale = start.w + (finish.w - start.w) * easeInOutCubic(t);

            vec2 away = centre - cursor;
            float dist = length(away);
            float near = max(0.0, 1.0 - dist / 2.4);
            float push = presence * near * near * 1.5;
            if (push > 0.001) {
                centre += dist < 0.0001 ? vec2(0.0, -push) : away / dist * push;
                rot += push * 40.0;
            }

            float r = radians(rot);
            vec2 p = corner * scale;
            p = vec2(p.x * cos(r) - p.y * sin(r), p.x * sin(r) + p.y * cos(r)) + centre;
            gl_Position = vec4(p.x / 10.0, -p.y / 10.0, 0.0, 1.0);

            colour = tone < 0.5 ? tone0 : tone < 1.5 ? tone1 : tone < 2.5 ? tone2 : tone3;
        }
    |]


fragmentShader : Shader {} Uniforms { colour : Vec3 }
fragmentShader =
    [glsl|
        precision mediump float;
        varying vec3 colour;

        void main() {
            gl_FragColor = vec4(colour, 1.0);
        }
    |]
