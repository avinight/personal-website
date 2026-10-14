module Palette exposing (Palette, dark, light, mix)

{-| The theme colours the WebGL drawings use, as 0–1 RGB. They match the
`--primary`, `--accent`, `--primary-strong` and `--accent-strong` variables in
styles/global.css, so keep the two in step.
-}

import Math.Vector3 as Vec3 exposing (Vec3, vec3)


type alias Palette =
    { primary : Vec3
    , accent : Vec3
    , primaryStrong : Vec3
    , accentStrong : Vec3
    }


light : Palette
light =
    { primary = hex 0xC0 0x62 0x3A
    , accent = hex 0x2E 0x7D 0x7E
    , primaryStrong = hex 0x9A 0x45 0x26
    , accentStrong = hex 0x20 0x56 0x57
    }


dark : Palette
dark =
    { primary = hex 0xE5 0x8A 0x5B
    , accent = hex 0x7F 0xC8 0xC9
    , primaryStrong = hex 0xF2 0xA5 0x81
    , accentStrong = hex 0xA3 0xDE 0xE0
    }


hex : Int -> Int -> Int -> Vec3
hex r g b =
    vec3 (toFloat r / 255) (toFloat g / 255) (toFloat b / 255)


{-| `mix 0 a b` is `a`, `mix 1 a b` is `b`.
-}
mix : Float -> Palette -> Palette -> Palette
mix t a b =
    let
        blend from to =
            Vec3.add from (Vec3.scale t (Vec3.sub to from))
    in
    { primary = blend a.primary b.primary
    , accent = blend a.accent b.accent
    , primaryStrong = blend a.primaryStrong b.primaryStrong
    , accentStrong = blend a.accentStrong b.accentStrong
    }
