module Backdrop exposing (Model, Msg, init, subscriptions, update, view)

{-| Faint wireframes of the five Platonic solids, nested the way Kepler drew
them in Mysterium Cosmographicum: a cube around a tetrahedron around a
dodecahedron around an icosahedron around an octahedron. Each one turns on
its own axis, in its own direction and at its own speed, behind every page,
and the whole nest leans toward the mouse. They are drawn as plain SVG
lines: the corners are rotated each frame and the edges joined up.
-}


import Array exposing (Array)
import Browser.Events
import Html exposing (Html)
import Html.Attributes as HA
import Json.Decode as Decode
import Svg exposing (Svg)
import Svg.Attributes as SA



-- SHAPE


type alias Vec =
    { x : Float
    , y : Float
    , z : Float
    }


phi : Float
phi =
    (1 + sqrt 5) / 2


{-| One solid in the nest. `size` is its distance from the centre to a
corner; `yawSpeed` and `pitchSpeed` set how fast, and which way, it turns
about the vertical and horizontal axes; `tone` picks its colour in CSS.
-}
type alias Solid =
    { corners : List Vec
    , edges : List ( Int, Int )
    , size : Float
    , yawSpeed : Float
    , pitchSpeed : Float
    , offset : Float
    , tone : String
    }


{-| Outermost first, as Kepler ordered them. The icosahedron keeps the size
and spin it had when it turned on its own.
-}
solids : List Solid
solids =
    [ solid cube { size = 1.45, yawSpeed = -0.55, pitchSpeed = 0.3, offset = 0.9, tone = "primary" }
    , solid tetrahedron { size = 1.25, yawSpeed = 0.8, pitchSpeed = -0.45, offset = 2.1, tone = "accent" }
    , solid dodecahedron { size = 1.1, yawSpeed = -0.7, pitchSpeed = 0.55, offset = 0.4, tone = "primary" }
    , solid icosahedron { size = 1, yawSpeed = 1, pitchSpeed = 0.7, offset = 0.35, tone = "accent" }
    , solid octahedron { size = 0.7, yawSpeed = -1.25, pitchSpeed = -0.85, offset = 1.3, tone = "primary" }
    ]


solid :
    List Vec
    -> { size : Float, yawSpeed : Float, pitchSpeed : Float, offset : Float, tone : String }
    -> Solid
solid rawCorners options =
    { corners = normalize rawCorners
    , edges = edgesOf rawCorners
    , size = options.size
    , yawSpeed = options.yawSpeed
    , pitchSpeed = options.pitchSpeed
    , offset = options.offset
    , tone = options.tone
    }


cube : List Vec
cube =
    signs3 |> List.map (\( a, b, c ) -> Vec a b c)


{-| Every other corner of the cube.
-}
tetrahedron : List Vec
tetrahedron =
    [ Vec 1 1 1, Vec 1 (-1) (-1), Vec (-1) 1 (-1), Vec (-1) (-1) 1 ]


octahedron : List Vec
octahedron =
    [ Vec 1 0 0, Vec (-1) 0 0, Vec 0 1 0, Vec 0 (-1) 0, Vec 0 0 1, Vec 0 0 (-1) ]


{-| (0, ±1, ±φ) and its two rotations.
-}
icosahedron : List Vec
icosahedron =
    signs2
        |> List.concatMap
            (\( a, b ) ->
                [ Vec 0 a (b * phi)
                , Vec a (b * phi) 0
                , Vec (b * phi) 0 a
                ]
            )


{-| The cube's corners plus (0, ±1/φ, ±φ) and its two rotations.
-}
dodecahedron : List Vec
dodecahedron =
    cube
        ++ (signs2
                |> List.concatMap
                    (\( a, b ) ->
                        [ Vec 0 (a / phi) (b * phi)
                        , Vec (a / phi) (b * phi) 0
                        , Vec (b * phi) 0 (a / phi)
                        ]
                    )
           )


signs2 : List ( Float, Float )
signs2 =
    [ ( 1, 1 ), ( 1, -1 ), ( -1, 1 ), ( -1, -1 ) ]


signs3 : List ( Float, Float, Float )
signs3 =
    List.concatMap (\( a, b ) -> [ ( a, b, 1 ), ( a, b, -1 ) ]) signs2


distanceSquared : Vec -> Vec -> Float
distanceSquared a b =
    (a.x - b.x) ^ 2 + (a.y - b.y) ^ 2 + (a.z - b.z) ^ 2


{-| In a Platonic solid the edges are exactly the pairs of corners that are
closest together.
-}
edgesOf : List Vec -> List ( Int, Int )
edgesOf points =
    let
        indexed =
            List.indexedMap Tuple.pair points

        pairs =
            indexed
                |> List.concatMap
                    (\( i, a ) ->
                        List.filterMap
                            (\( j, b ) ->
                                if j > i then
                                    Just ( i, j, distanceSquared a b )

                                else
                                    Nothing
                            )
                            indexed
                    )

        shortest =
            pairs
                |> List.map (\( _, _, d ) -> d)
                |> List.minimum
                |> Maybe.withDefault 0
    in
    List.filterMap
        (\( i, j, d ) ->
            if abs (d - shortest) < 0.001 then
                Just ( i, j )

            else
                Nothing
        )
        pairs


{-| Scale corners to sit on a sphere of radius 1.
-}
normalize : List Vec -> List Vec
normalize points =
    let
        radius =
            points
                |> List.map (\v -> sqrt (v.x * v.x + v.y * v.y + v.z * v.z))
                |> List.maximum
                |> Maybe.withDefault 1
    in
    List.map (\v -> Vec (v.x / radius) (v.y / radius) (v.z / radius)) points



-- MODEL


type alias Model =
    { angle : Float
    , tilt : ( Float, Float )
    , target : ( Float, Float )
    , reducedMotion : Bool
    }


init : Bool -> Model
init reducedMotion =
    { angle = 0.6
    , tilt = ( 0, 0 )
    , target = ( 0, 0 )
    , reducedMotion = reducedMotion
    }


type Msg
    = Frame Float
    | MouseMoved Float Float Float Float


update : Msg -> Model -> Model
update msg model =
    case msg of
        Frame rawDelta ->
            let
                delta =
                    min rawDelta 50

                ( tx, ty ) =
                    model.tilt

                ( gx, gy ) =
                    model.target

                follow =
                    1 - e ^ (-delta / 450)
            in
            { model
                | angle = model.angle + delta * 0.00012
                , tilt = ( tx + (gx - tx) * follow, ty + (gy - ty) * follow )
            }

        MouseMoved clientX clientY width height ->
            if width <= 0 || height <= 0 then
                model

            else
                { model | target = ( clientX / width * 2 - 1, clientY / height * 2 - 1 ) }


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.reducedMotion then
        Sub.none

    else
        Sub.batch
            [ Browser.Events.onAnimationFrameDelta Frame
            , Browser.Events.onMouseMove mouseDecoder
            ]


mouseDecoder : Decode.Decoder Msg
mouseDecoder =
    Decode.map4 MouseMoved
        (Decode.field "clientX" Decode.float)
        (Decode.field "clientY" Decode.float)
        (Decode.at [ "view", "innerWidth" ] Decode.float)
        (Decode.at [ "view", "innerHeight" ] Decode.float)



-- VIEW


{-| Turn a corner of a solid by its own spin plus the lean toward the mouse,
then project it with a little perspective. `z` points at the viewer and is
returned relative to the solid's size, so depth fading works at any size.
-}
place : Model -> Solid -> Vec -> Vec
place model shape v =
    let
        ( tx, ty ) =
            model.tilt

        yaw =
            model.angle * shape.yawSpeed + shape.offset + tx * 0.45

        pitch =
            model.angle * shape.pitchSpeed + shape.offset + ty * 0.35

        x1 =
            v.x * cos yaw + v.z * sin yaw

        z1 =
            v.z * cos yaw - v.x * sin yaw

        y2 =
            v.y * cos pitch - z1 * sin pitch

        z2 =
            v.y * sin pitch + z1 * cos pitch

        perspective =
            4 / (4 - z2 * shape.size)
    in
    { x = x1 * shape.size * perspective, y = y2 * shape.size * perspective, z = z2 }


view : Model -> Html msg
view model =
    Svg.svg
        [ SA.class "backdrop"
        , SA.viewBox "-1.25 -1.25 2.5 2.5"
        , SA.preserveAspectRatio "xMidYMid slice"
        , HA.attribute "aria-hidden" "true"
        ]
        (List.map (viewSolid model) solids)


viewSolid : Model -> Solid -> Svg msg
viewSolid model shape =
    let
        points =
            Array.fromList (List.map (place model shape) shape.corners)
    in
    Svg.g [ SA.class ("solid solid-" ++ shape.tone) ]
        (List.map (viewEdge points) shape.edges
            ++ List.map viewCorner (Array.toList points)
        )


{-| Edges further back are fainter.
-}
viewEdge : Array Vec -> ( Int, Int ) -> Svg msg
viewEdge points ( i, j ) =
    case ( Array.get i points, Array.get j points ) of
        ( Just a, Just b ) ->
            Svg.line
                [ SA.x1 (String.fromFloat a.x)
                , SA.y1 (String.fromFloat a.y)
                , SA.x2 (String.fromFloat b.x)
                , SA.y2 (String.fromFloat b.y)
                , SA.strokeOpacity (String.fromFloat (depthFade ((a.z + b.z) / 2)))
                ]
                []

        _ ->
            Svg.text ""


viewCorner : Vec -> Svg msg
viewCorner point =
    Svg.circle
        [ SA.cx (String.fromFloat point.x)
        , SA.cy (String.fromFloat point.y)
        , SA.r "0.001"
        , SA.strokeWidth "0.09"
        , SA.fillOpacity (String.fromFloat (depthFade point.z))
        ]
        []


depthFade : Float -> Float
depthFade z =
    0.3 + 0.7 * clamp 0 1 ((z + 1) / 2)
