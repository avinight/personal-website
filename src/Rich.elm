module Rich exposing (view)

{-| Light inline markup for the data files: `*text*` is bold, `$tex$`
is rendered by KaTeX through the `katex-math` custom element, and
`[text](url)` is a link that opens in a new tab.
-}

import Html exposing (Html, a, node, strong, text)
import Html.Attributes exposing (attribute, class, href, rel, target)


view : String -> List (Html msg)
view source =
    String.split "$" source
        |> List.indexedMap
            (\i part ->
                if modBy 2 i == 1 then
                    [ node "katex-math" [ attribute "tex" part ] [] ]

                else
                    links part
            )
        |> List.concat


links : String -> List (Html msg)
links part =
    case String.split "[" part of
        [] ->
            []

        first :: chunks ->
            bold first ++ List.concatMap linkChunk chunks


{-| A chunk is whatever followed a `[`. If it reads `label](url)rest` it
becomes a link; otherwise the `[` was just a bracket.
-}
linkChunk : String -> List (Html msg)
linkChunk chunk =
    case String.split "](" chunk of
        label :: afterLabel :: more ->
            let
                remainder =
                    String.join "](" (afterLabel :: more)
            in
            case String.indexes ")" remainder of
                close :: _ ->
                    a
                        [ class "rich-link"
                        , href (String.left close remainder)
                        , target "_blank"
                        , rel "noopener noreferrer"
                        ]
                        (bold label)
                        :: bold (String.dropLeft (close + 1) remainder)

                [] ->
                    bold ("[" ++ chunk)

        _ ->
            bold ("[" ++ chunk)


bold : String -> List (Html msg)
bold part =
    String.split "*" part
        |> List.indexedMap
            (\i piece ->
                if modBy 2 i == 1 then
                    strong [] [ text piece ]

                else
                    text piece
            )
