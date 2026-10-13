module Page.Home exposing (view)

import Data.Bio as Bio exposing (IconGroup)
import Html exposing (Html, div, h1, h2, main_, p, section, span, text)
import Html.Attributes exposing (attribute, class, classList, id, title)
import Icon


{-| `typed` is how many letters of the greeting have been typed out so far.
-}
view : { typed : Int, logo : Html msg } -> Html msg
view { typed, logo } =
    div [ class "page-home" ]
        [ div [ id "container" ]
            [ main_ []
                [ div [ id "hero" ]
                    [ div [ class "hero-top" ]
                        [ h1 [ id "greeting", attribute "aria-label" Bio.greeting ]
                            [ span [ attribute "aria-hidden" "true" ] [ text (String.left typed Bio.greeting) ]
                            , span
                                [ classList
                                    [ ( "caret", True )
                                    , ( "done", typed >= String.length Bio.greeting )
                                    ]
                                ]
                                []
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
