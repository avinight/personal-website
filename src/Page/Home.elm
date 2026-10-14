module Page.Home exposing (view)

import Data.Bio as Bio exposing (IconGroup)
import Html exposing (Html, div, h1, h2, main_, p, section, span, text)
import Html.Attributes exposing (attribute, class, id, title)
import Icon


{-| `typed` is how many letters of the greeting have been typed out so far,
and `caret` follows them.
-}
view : { typed : Int, caret : Html msg, logo : Html msg } -> Html msg
view { typed, caret, logo } =
    div [ class "page-home" ]
        [ div [ class "page-container" ]
            [ main_ []
                [ div [ id "hero" ]
                    [ div [ class "hero-top" ]
                        [ h1 [ id "greeting", attribute "aria-label" Bio.greeting ]
                            [ span [ attribute "aria-hidden" "true" ] [ text (String.left typed Bio.greeting) ]
                            , caret
                            ]
                        , logo
                        ]
                    , section [ class "box" ] (List.map (\paragraph -> p [] [ text paragraph ]) Bio.about)
                    , iconBox Bio.techStack
                    , iconBox Bio.languages
                    ]
                ]
            ]
        ]


iconBox : IconGroup -> Html msg
iconBox group =
    section [ class "box" ]
        [ h2 [] [ text group.heading ]
        , div [ class "icon-grid" ]
            (List.map
                (\item ->
                    span [ class "tech-icon", title item.name, attribute "aria-label" item.name ]
                        [ Icon.view item.icon ]
                )
                group.items
            )
        ]
