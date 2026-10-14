module Decor exposing (caret, caretLife, caretVisible, pulse)

{-| Small WebGL flourishes: the blinking caret after the home page greeting
and the pulsing ring on the newest timeline entry on the About page. Each is
one quad on its own little canvas, sized by CSS.
-}

import Html exposing (Html)
import Html.Attributes as HA
import Html.Lazy
import Math.Vector2 exposing (Vec2, vec2)
import Math.Vector3 exposing (Vec3)
import Palette
import WebGL exposing (Mesh, Shader)
import WebGL.Settings.Blend as Blend



-- CARET


{-| Once the greeting is typed out, the caret blinks three times, 0.7 s
each, then goes away. `age` is how long ago the typing finished, or
`Nothing` while it is still going.
-}
caretVisible : Maybe Float -> Bool
caretVisible age =
    case age of
        Nothing ->
            True

        Just ms ->
            ms < caretLife && ms - 700 * toFloat (floor (ms / 700)) < 350


{-| How long the caret lasts after the typing finishes.
-}
caretLife : Float
caretLife =
    2100


caret : Bool -> Bool -> Html msg
caret dark visible =
    Html.Lazy.lazy2 viewCaret dark visible


viewCaret : Bool -> Bool -> Html msg
viewCaret dark visible =
    WebGL.toHtmlWith
        [ WebGL.alpha True, WebGL.clearColor 0 0 0 0 ]
        [ HA.class "caret", HA.attribute "aria-hidden" "true", HA.width 4, HA.height 64 ]
        (if visible then
            [ WebGL.entity quadVertex
                fillFragment
                quad
                { colour = (palette dark).primary }
            ]

         else
            []
        )


fillFragment : Shader {} { colour : Vec3 } {}
fillFragment =
    [glsl|
        precision mediump float;
        uniform vec3 colour;

        void main() {
            gl_FragColor = vec4(colour, 1.0);
        }
    |]



-- PULSE


{-| One pulse, in milliseconds.
-}
pulseLength : Float
pulseLength =
    2400


{-| The canvas is this many CSS pixels across, enough for the ring at its
largest, and is centred on the timeline dot (see about.css).
-}
pulseCanvas : Float
pulseCanvas =
    48


{-| A ring over the dot's 18 px border that grows to 2.4 times its size and
fades out, easing out, every 2.4 s. `clock` is how long the page has been
open, or `Nothing` with reduced motion, which leaves the ring still.
-}
pulse : Float -> Bool -> Maybe Float -> Html msg
pulse pixelRatio dark clock =
    let
        ( scale, alpha ) =
            case clock of
                Nothing ->
                    ( 1, 1 )

                Just ms ->
                    let
                        t =
                            easeOut ((ms - pulseLength * toFloat (floor (ms / pulseLength))) / pulseLength)
                    in
                    ( 1 + 1.4 * t, 0.8 * (1 - t) )
    in
    Html.Lazy.lazy4 viewPulse (min 2 pixelRatio) dark scale alpha


viewPulse : Float -> Bool -> Float -> Float -> Html msg
viewPulse dpr dark scale alpha =
    let
        size =
            round (pulseCanvas * dpr)
    in
    WebGL.toHtmlWith
        [ WebGL.alpha True, WebGL.antialias, WebGL.clearColor 0 0 0 0 ]
        [ HA.class "pulse", HA.attribute "aria-hidden" "true", HA.width size, HA.height size ]
        [ WebGL.entityWith [ Blend.add Blend.one Blend.oneMinusSrcAlpha ]
            quadVertex
            ringFragment
            quad
            { colour = (palette dark).accent
            , alpha = alpha
            , centre = toFloat size / 2
            , outer = 9 * scale * dpr
            , thickness = 2 * scale * dpr
            }
        ]


type alias RingUniforms =
    { colour : Vec3
    , alpha : Float
    , centre : Float
    , outer : Float
    , thickness : Float
    }


{-| Distances are in device pixels, with half a pixel of softening on each
edge, as the browser antialiases a CSS border.
-}
ringFragment : Shader {} RingUniforms {}
ringFragment =
    [glsl|
        precision mediump float;
        uniform vec3 colour;
        uniform float alpha;
        uniform float centre;
        uniform float outer;
        uniform float thickness;

        void main() {
            float d = length(gl_FragCoord.xy - vec2(centre));
            float a = clamp(outer - d + 0.5, 0.0, 1.0)
                * clamp(d - (outer - thickness) + 0.5, 0.0, 1.0)
                * alpha;
            gl_FragColor = vec4(colour * a, a);
        }
    |]


{-| CSS `ease-out`, `cubic-bezier(0, 0, 0.58, 1)`.
-}
easeOut : Float -> Float
easeOut x =
    let
        -- x and y both have their first control point at 0, so only the second
        -- one, 0.58 for x and 1 for y, and the end point at 1 remain.
        curve control u =
            3 * (1 - u) * u * u * control + u * u * u

        solve lo hi n =
            let
                mid =
                    (lo + hi) / 2
            in
            if n == 0 then
                mid

            else if curve 0.58 mid < x then
                solve mid hi (n - 1)

            else
                solve lo mid (n - 1)

        t =
            solve 0 1 20
    in
    curve 1 t



-- SHARED


palette : Bool -> Palette.Palette
palette dark =
    if dark then
        Palette.dark

    else
        Palette.light


quad : Mesh { position : Vec2 }
quad =
    WebGL.triangles
        [ ( { position = vec2 -1 -1 }, { position = vec2 1 -1 }, { position = vec2 -1 1 } )
        , ( { position = vec2 -1 1 }, { position = vec2 1 -1 }, { position = vec2 1 1 } )
        ]


quadVertex : Shader { position : Vec2 } uniforms {}
quadVertex =
    [glsl|
        attribute vec2 position;

        void main() {
            gl_Position = vec4(position, 0.0, 1.0);
        }
    |]
