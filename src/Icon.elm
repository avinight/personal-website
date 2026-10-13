module Icon exposing (view, viewWith)

{-| Icons are SVG files in public/icons, exported by `npm run icons`.
Single-colour sets are drawn as a CSS mask so they follow `currentColor`;
twemoji keeps its own colours and is shown as an image.
-}

import Html exposing (Html, img, span)
import Html.Attributes exposing (alt, attribute, class, src, style)


view : String -> Html msg
view =
    viewWith ""


viewWith : String -> String -> Html msg
viewWith extraClass name =
    let
        url =
            "/icons/" ++ String.replace ":" "/" name ++ ".svg"

        classes =
            String.trim ("icon " ++ extraClass)
    in
    if String.startsWith "twemoji:" name then
        img [ class (classes ++ " icon-color"), src url, alt "" ] []

    else
        span
            [ class classes
            , attribute "aria-hidden" "true"
            , style "mask-image" ("url(" ++ url ++ ")")
            , style "-webkit-mask-image" ("url(" ++ url ++ ")")
            ]
            []
