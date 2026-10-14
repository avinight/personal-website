module Backdrop exposing (Model, Msg, Screen, init, lookAt, subscriptions, update, view)

{-| Faint wireframes of the five Platonic solids, nested the way Kepler drew
them in Mysterium Cosmographicum: a cube around a tetrahedron around a
dodecahedron around an icosahedron around an octahedron. Each one turns on
its own axis, in its own direction and at its own speed, behind every page,
and the whole nest leans toward the mouse.

Each solid's edges and corner rings are built into a mesh once, and the GPU
turns and projects them, so a frame only sends each solid's angles: there
are no vertices to rebuild or upload, and the page itself never changes.

-}

import Browser.Events
import Html exposing (Html)
import Html.Attributes as HA
import Html.Lazy
import Math.Vector2 exposing (Vec2, vec2)
import Math.Vector3 as Vec3 exposing (Vec3, vec3)
import Math.Vector4 exposing (Vec4, vec4)
import Palette exposing (Palette)
import WebGL exposing (Mesh, Shader)
import WebGL.Settings.Blend as Blend



-- SHAPE


type alias Point =
    ( Float, Float, Float )


phi : Float
phi =
    (1 + sqrt 5) / 2


signs2 : List ( Float, Float )
signs2 =
    [ ( 1, 1 ), ( 1, -1 ), ( -1, 1 ), ( -1, -1 ) ]


cube : List Point
cube =
    List.concatMap (\( a, b ) -> [ ( a, b, 1 ), ( a, b, -1 ) ]) signs2


{-| Every other corner of the cube.
-}
tetrahedron : List Point
tetrahedron =
    [ ( 1, 1, 1 ), ( 1, -1, -1 ), ( -1, 1, -1 ), ( -1, -1, 1 ) ]


octahedron : List Point
octahedron =
    [ ( 1, 0, 0 ), ( -1, 0, 0 ), ( 0, 1, 0 ), ( 0, -1, 0 ), ( 0, 0, 1 ), ( 0, 0, -1 ) ]


{-| (0, ±1, ±φ) and its two rotations.
-}
icosahedron : List Point
icosahedron =
    List.concatMap (\( a, b ) -> [ ( 0, a, b * phi ), ( a, b * phi, 0 ), ( b * phi, 0, a ) ]) signs2


{-| The cube's corners plus (0, ±1/φ, ±φ) and its two rotations.
-}
dodecahedron : List Point
dodecahedron =
    cube
        ++ List.concatMap
            (\( a, b ) -> [ ( 0, a / phi, b * phi ), ( a / phi, b * phi, 0 ), ( b * phi, 0, a / phi ) ])
            signs2


{-| `size` is a solid's distance from the centre to a corner; `yawSpeed` and
`pitchSpeed` set how fast, and which way, it turns about the vertical and
horizontal axes; `tone` picks its colour from the theme.
-}
type alias Solid =
    { mesh : Mesh Vertex
    , size : Float
    , yawSpeed : Float
    , pitchSpeed : Float
    , offset : Float
    , tone : Palette -> Vec3
    }


{-| Outermost first, as Kepler ordered them.
-}
solids : List Solid
solids =
    [ { mesh = meshOf cube, size = 1.45, yawSpeed = -0.55, pitchSpeed = 0.3, offset = 0.9, tone = .primary }
    , { mesh = meshOf tetrahedron, size = 1.25, yawSpeed = 0.8, pitchSpeed = -0.45, offset = 2.1, tone = .accent }
    , { mesh = meshOf dodecahedron, size = 1.1, yawSpeed = -0.7, pitchSpeed = 0.55, offset = 0.4, tone = .primary }
    , { mesh = meshOf icosahedron, size = 1, yawSpeed = 1, pitchSpeed = 0.7, offset = 0.35, tone = .accent }
    , { mesh = meshOf octahedron, size = 0.7, yawSpeed = -1.25, pitchSpeed = -0.85, offset = 1.3, tone = .primary }
    ]



-- LOOK


{-| The nest spans 2.5 units across the longer side of the screen, so it
always fills it.
-}
span : Float
span =
    2.5


{-| In CSS pixels.
-}
lineWidth : Float
lineWidth =
    1.25


{-| In the nest's units.
-}
ringRadius : Float
ringRadius =
    0.046


ringSides : Int
ringSides =
    32



-- MESH


{-| Every vertex belongs to an edge from `a` to `b`: `along` is 0 at `a` and
1 at `b`, and `side` pushes it half a line width to one side or the other.
A corner ring is an edge from its corner to itself, and `ring` holds the
direction out from the corner and whether the vertex is on the ring's outer
(1) or inner (0) edge.
-}
type alias Vertex =
    { a : Vec3
    , b : Vec3
    , along : Float
    , side : Float
    , ring : Vec3
    }


meshOf : List Point -> Mesh Vertex
meshOf points =
    let
        corners =
            normalize points

        edges =
            List.map (\( i, j ) -> edgeTriangles (at i corners) (at j corners)) (edgesOf points)
    in
    WebGL.triangles (List.concat edges ++ List.concatMap ringTriangles corners)


edgeTriangles : Vec3 -> Vec3 -> List ( Vertex, Vertex, Vertex )
edgeTriangles a b =
    let
        corner along side =
            { a = a, b = b, along = along, side = side, ring = vec3 0 0 0 }
    in
    [ ( corner 0 1, corner 0 -1, corner 1 1 )
    , ( corner 1 1, corner 0 -1, corner 1 -1 )
    ]


ringTriangles : Vec3 -> List ( Vertex, Vertex, Vertex )
ringTriangles centre =
    let
        point s rim =
            let
                t =
                    toFloat s / toFloat ringSides * 2 * pi
            in
            { a = centre, b = centre, along = 0, side = 0, ring = vec3 (cos t) (sin t) rim }
    in
    List.range 0 (ringSides - 1)
        |> List.concatMap
            (\s ->
                [ ( point s 1, point s 0, point (s + 1) 1 )
                , ( point (s + 1) 1, point s 0, point (s + 1) 0 )
                ]
            )


{-| In a Platonic solid the edges are exactly the pairs of corners that are
closest together.
-}
edgesOf : List Point -> List ( Int, Int )
edgesOf points =
    let
        indexed =
            List.indexedMap Tuple.pair points

        pairs =
            List.concatMap
                (\( i, p ) ->
                    List.filterMap
                        (\( j, q ) ->
                            if j > i then
                                Just ( i, j, distanceSquared p q )

                            else
                                Nothing
                        )
                        indexed
                )
                indexed

        shortest =
            pairs |> List.map (\( _, _, d ) -> d) |> List.minimum |> Maybe.withDefault 0
    in
    List.filterMap
        (\( i, j, d ) ->
            if abs (d - shortest) < 0.001 then
                Just ( i, j )

            else
                Nothing
        )
        pairs


distanceSquared : Point -> Point -> Float
distanceSquared ( ax, ay, az ) ( bx, by, bz ) =
    (ax - bx) ^ 2 + (ay - by) ^ 2 + (az - bz) ^ 2


{-| Scale corners to sit on a sphere of radius 1.
-}
normalize : List Point -> List Vec3
normalize points =
    let
        vectors =
            List.map (\( x, y, z ) -> vec3 x y z) points

        radius =
            vectors |> List.map Vec3.length |> List.maximum |> Maybe.withDefault 1
    in
    List.map (Vec3.scale (1 / radius)) vectors


at : Int -> List Vec3 -> Vec3
at i list =
    List.drop i list |> List.head |> Maybe.withDefault (vec3 0 0 0)



-- MODEL


{-| How the nest is turned: `angle` grows with time, and the tilt eases
toward the target, which follows the mouse.
-}
type alias Model =
    { angle : Float
    , tiltX : Float
    , tiltY : Float
    , targetX : Float
    , targetY : Float
    }


init : Model
init =
    { angle = 0.6, tiltX = 0, tiltY = 0, targetX = 0, targetY = 0 }


{-| Where the mouse is, from -1 to 1 across and down the window.
-}
lookAt : Float -> Float -> Model -> Model
lookAt x y model =
    { model | targetX = x, targetY = y }



-- UPDATE


type Msg
    = Frame Float


update : Msg -> Model -> Model
update (Frame delta) model =
    let
        dt =
            min delta 50

        follow =
            1 - e ^ (-dt / 450)
    in
    { model
        | angle = model.angle + dt * 0.00012
        , tiltX = model.tiltX + (model.targetX - model.tiltX) * follow
        , tiltY = model.tiltY + (model.targetY - model.tiltY) * follow
    }


{-| With reduced motion the nest is drawn once and stays still.
-}
subscriptions : Bool -> Sub Msg
subscriptions reducedMotion =
    if reducedMotion then
        Sub.none

    else
        Browser.Events.onAnimationFrameDelta Frame



-- VIEW


{-| The page's size in CSS pixels and its device pixel ratio.
-}
type alias Screen =
    { width : Float
    , height : Float
    , pixelRatio : Float
    }


{-| Only redrawn when the nest has turned, the window has changed or the
theme has switched.
-}
view : Screen -> Bool -> Model -> Html msg
view screen dark model =
    Html.Lazy.lazy7 viewNest
        screen.width
        screen.height
        screen.pixelRatio
        dark
        model.angle
        model.tiltX
        model.tiltY


viewNest : Float -> Float -> Float -> Bool -> Float -> Float -> Float -> Html msg
viewNest width height pixelRatio dark angle tiltX tiltY =
    let
        dpr =
            min 2 pixelRatio

        w =
            round (width * dpr)

        h =
            round (height * dpr)

        palette =
            if dark then
                Palette.dark

            else
                Palette.light

        shared =
            { screen = vec2 (toFloat w) (toFloat h)
            , scale = max width height / span * dpr
            , halfLine = lineWidth * dpr / 2
            }

        entity solid =
            let
                yaw =
                    angle * solid.yawSpeed + solid.offset + tiltX * 0.45

                pitch =
                    angle * solid.pitchSpeed + solid.offset + tiltY * 0.35
            in
            WebGL.entityWith [ Blend.add Blend.one Blend.oneMinusSrcAlpha ]
                vertexShader
                fragmentShader
                solid.mesh
                { turn = vec4 (cos yaw) (sin yaw) (cos pitch) (sin pitch)
                , size = solid.size
                , colour = solid.tone palette
                , screen = shared.screen
                , scale = shared.scale
                , halfLine = shared.halfLine
                , ringRadius = ringRadius * shared.scale
                }
    in
    WebGL.toHtmlWith
        [ WebGL.alpha True, WebGL.antialias, WebGL.clearColor 0 0 0 0 ]
        [ HA.class "backdrop"
        , HA.attribute "aria-hidden" "true"
        , HA.width w
        , HA.height h
        ]
        (if w > 0 && h > 0 then
            List.map entity solids

         else
            []
        )


type alias Uniforms =
    { turn : Vec4
    , size : Float
    , colour : Vec3
    , screen : Vec2
    , scale : Float
    , halfLine : Float
    , ringRadius : Float
    }


{-| Turns both ends of the edge, projects them with a little perspective (`z`
points at the viewer and is relative to the solid's size), and places the
vertex in device pixels from the middle of the screen. Edges and corners
further back are fainter.
-}
vertexShader : Shader Vertex Uniforms { alpha : Float }
vertexShader =
    [glsl|
        attribute vec3 a;
        attribute vec3 b;
        attribute float along;
        attribute float side;
        attribute vec3 ring;
        uniform vec4 turn;
        uniform float size;
        uniform vec2 screen;
        uniform float scale;
        uniform float halfLine;
        uniform float ringRadius;
        varying float alpha;

        vec3 project(vec3 p) {
            float x1 = p.x * turn.x + p.z * turn.y;
            float z1 = p.z * turn.x - p.x * turn.y;
            float y2 = p.y * turn.z - z1 * turn.w;
            float z2 = p.y * turn.w + z1 * turn.z;
            float perspective = 4.0 / (4.0 - z2 * size) * size * scale;
            return vec3(x1 * perspective, y2 * perspective, z2);
        }

        void main() {
            vec3 pa = project(a);
            vec3 pb = project(b);
            vec2 d = pb.xy - pa.xy;
            float len = length(d);
            vec2 normal = len > 0.0 ? vec2(-d.y, d.x) / len : vec2(0.0);
            float radius = ringRadius - (1.0 - ring.z) * 2.0 * halfLine;
            vec2 p = mix(pa.xy, pb.xy, along) + normal * side * halfLine + ring.xy * radius;
            gl_Position = vec4(p.x / screen.x * 2.0, -p.y / screen.y * 2.0, 0.0, 1.0);
            alpha = 0.3 + 0.7 * clamp(((pa.z + pb.z) / 2.0 + 1.0) / 2.0, 0.0, 1.0);
        }
    |]


fragmentShader : Shader {} Uniforms { alpha : Float }
fragmentShader =
    [glsl|
        precision mediump float;
        uniform vec3 colour;
        varying float alpha;

        void main() {
            gl_FragColor = vec4(colour * alpha, alpha);
        }
    |]
