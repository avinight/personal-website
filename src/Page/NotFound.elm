module Page.NotFound exposing (view)

import Html exposing (Html, a, div, h1, main_, p, text)
import Html.Attributes exposing (class, href, id)


view : Html msg
view =
    div [ class "page-blog" ]
        [ div [ id "container" ]
            [ main_ []
                [ div [ id "content" ]
                    [ h1 [] [ text "Page not found" ]
                    , p [ class "intro" ]
                        [ text "There's nothing at this address. "
                        , a [ href "/" ] [ text "Head back home." ]
                        ]
                    ]
                ]
            ]
        ]
