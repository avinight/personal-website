module Logo exposing (Model, Msg, init, subscriptions, update, view)

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
import Svg exposing (Svg)
import Svg.Attributes as SA



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



-- MODEL


type alias Model =
    { index : Int
    , from : List Pose
    , to : List Pose
    , elapsed : Float
    , reducedMotion : Bool
    , pointer : Maybe ( Float, Float )
    , cursor : ( Float, Float )
    , presence : Float
    }


{-| Shards start hidden on a spiral around the logo and assemble into the
first picture.
-}
init : Bool -> Model
init reducedMotion =
    let
        target =
            posesFor 0 scattered
    in
    if reducedMotion then
        { index = 0
        , from = target
        , to = target
        , elapsed = settled
        , reducedMotion = True
        , pointer = Nothing
        , cursor = ( 0, 0 )
        , presence = 0
        }

    else
        { index = 0
        , from = scattered
        , to = target
        , elapsed = 0
        , reducedMotion = False
        , pointer = Nothing
        , cursor = ( 0, 0 )
        , presence = 0
        }


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
        { model | index = next, from = target, to = target, elapsed = settled }

    else
        { model | index = next, from = current, to = target, elapsed = 0 }


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.reducedMotion then
        Sub.none

    else
        Browser.Events.onAnimationFrameDelta Frame



-- ANIMATION


{-| Shards near the pointer are pushed outward and tilted, more strongly the
closer they are.
-}
repel : Model -> Pose -> Pose
repel model pose =
    let
        ( cx, cy ) =
            model.cursor

        dx =
            pose.x - cx

        dy =
            pose.y - cy

        dist =
            sqrt (dx * dx + dy * dy)

        reach =
            2.4

        push =
            model.presence * ((max 0 (1 - dist / reach)) ^ 2) * 1.5
    in
    if push <= 0.001 then
        pose

    else if dist < 0.0001 then
        { pose | y = pose.y - push, rot = pose.rot + push * 40 }

    else
        { pose
            | x = pose.x + dx / dist * push
            , y = pose.y + dy / dist * push
            , rot = pose.rot + push * 40
        }



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


easeInOutCubic : Float -> Float
easeInOutCubic t =
    if t < 0.5 then
        4 * t * t * t

    else
        1 - ((-2 * t + 2) ^ 3) / 2


{-| Pulls back slightly before leaving and overshoots a little on arrival.
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


view : Model -> Html Msg
view model =
    Html.button
        [ HA.class "logo"
        , HA.type_ "button"
        , HA.attribute "aria-label"
            ("Logo showing " ++ (pictureAt model.index).label ++ ". Press for the next picture.")
        , Html.Events.onClick Next
        , Html.Events.on "pointermove" pointerDecoder
        , Html.Events.on "pointerleave" (Decode.succeed PointerLeft)
        ]
        [ Svg.svg
            [ SA.viewBox "-5 -5 10 10"
            , SA.class "logo-art"
            , HA.attribute "aria-hidden" "true"
            ]
            (if isStill model then
                [ Html.Lazy.lazy viewShards model.to ]

             else
                List.indexedMap viewShard (List.map (repel model) (currentPoses model))
            )
        ]


{-| Between pictures, with nobody pointing at it, the logo doesn't move, so
it is drawn once and left alone until the next picture.
-}
isStill : Model -> Bool
isStill model =
    model.elapsed >= settled && model.presence < 0.0005


viewShards : List Pose -> Svg msg
viewShards poses =
    Svg.g [] (List.indexedMap viewShard poses)


{-| The SVG ignores the pointer (see logo.css), so offsets are measured
against the button, which is exactly the size of the drawing.
-}
pointerDecoder : Decode.Decoder Msg
pointerDecoder =
    Decode.map4 PointerMoved
        (Decode.field "offsetX" Decode.float)
        (Decode.field "offsetY" Decode.float)
        (Decode.at [ "currentTarget", "clientWidth" ] Decode.float)
        (Decode.at [ "currentTarget", "clientHeight" ] Decode.float)


viewShard : Int -> Pose -> Svg msg
viewShard i pose =
    Svg.polygon
        [ SA.points "-0.47,-0.47 0.47,-0.47 -0.47,0.47"
        , SA.class ("shard shard-" ++ String.fromInt (modBy 4 (i * 7 // 3)))
        , SA.transform
            ("translate("
                ++ String.fromFloat pose.x
                ++ " "
                ++ String.fromFloat pose.y
                ++ ") rotate("
                ++ String.fromFloat pose.rot
                ++ ") scale("
                ++ String.fromFloat pose.scale
                ++ ")"
            )
        ]
        []
