module Rich exposing (view)

{-| Light inline markup for the data files: `*text*` is bold and `$tex$`
is rendered by KaTeX through the `katex-math` custom element.
-}

import Html exposing (Html, node, strong, text)
import Html.Attributes exposing (attribute)


view : String -> List (Html msg)
view source =
    String.split "$" source
        |> List.indexedMap
            (\i part ->
                if modBy 2 i == 1 then
                    [ node "katex-math" [ attribute "tex" part ] [] ]

                else
                    bold part
            )
        |> List.concat


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
