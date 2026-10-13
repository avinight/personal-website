module Backdrop exposing (Model, Msg, init, subscriptions, update, view)

{-| A faint wireframe icosahedron that turns slowly behind every page and
leans toward the mouse. It is drawn as plain SVG lines: the twelve corners
are rotated each frame and the thirty edges joined up.
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


{-| The corners of an icosahedron are (0, ±1, ±φ) and its two rotations.
-}
corners : List Vec
corners =
    [ ( 1, 1 ), ( 1, -1 ), ( -1, 1 ), ( -1, -1 ) ]
        |> List.concatMap
            (\( a, b ) ->
                [ Vec 0 a (b * phi)
                , Vec a (b * phi) 0
                , Vec (b * phi) 0 a
                ]
            )


{-| Corners joined by an edge are exactly 2 apart.
-}
edges : List ( Int, Int )
edges =
    let
        indexed =
            List.indexedMap Tuple.pair corners

        distanceSquared a b =
            (a.x - b.x) ^ 2 + (a.y - b.y) ^ 2 + (a.z - b.z) ^ 2
    in
    indexed
        |> List.concatMap
            (\( i, a ) ->
                List.filterMap
                    (\( j, b ) ->
                        if j > i && abs (distanceSquared a b - 4) < 0.01 then
                            Just ( i, j )

                        else
                            Nothing
                    )
                    indexed
            )


{-| Corners scaled to sit on a sphere of radius 1.
-}
unitCorners : List Vec
unitCorners =
    let
        radius =
            sqrt (1 + phi * phi)
    in
    List.map (\v -> Vec (v.x / radius) (v.y / radius) (v.z / radius)) corners



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


{-| Turn a corner by the current spin plus the lean toward the mouse, then
project it with a little perspective. `z` points at the viewer.
-}
place : Model -> Vec -> Vec
place model v =
    let
        ( tx, ty ) =
            model.tilt

        yaw =
            model.angle + tx * 0.45

        pitch =
            model.angle * 0.7 + 0.35 + ty * 0.35

        x1 =
            v.x * cos yaw + v.z * sin yaw

        z1 =
            v.z * cos yaw - v.x * sin yaw

        y2 =
            v.y * cos pitch - z1 * sin pitch

        z2 =
            v.y * sin pitch + z1 * cos pitch

        perspective =
            4 / (4 - z2)
    in
    { x = x1 * perspective, y = y2 * perspective, z = z2 }


view : Model -> Html msg
view model =
    let
        points =
            Array.fromList (List.map (place model) unitCorners)
    in
    Svg.svg
        [ SA.class "backdrop"
        -- , SA.viewBox "-1.5 -1.5 3 3"
        , SA.viewBox "-1.25 -1.25 2.5 2.5"
        , SA.preserveAspectRatio "xMidYMid slice"
        , HA.attribute "aria-hidden" "true"
        ]
        (List.map (viewEdge points) edges
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
