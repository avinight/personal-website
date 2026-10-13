module Page.Blog exposing (viewList, viewPost)

import Html exposing (Html, a, article, div, h1, h2, header, main_, node, p, span, text, time)
import Html.Attributes exposing (attribute, class, href, id, property)
import Json.Encode as Encode
import Post exposing (Post)


viewList : List Post -> Html msg
viewList posts =
    div [ class "page-blog" ]
        [ div [ id "container" ]
            [ main_ []
                [ div [ id "content" ]
                    (h1 [] [ text "Blog" ]
                        :: (case Post.published posts of
                                [] ->
                                    [ p [ class "intro" ] [ text "Coming soon. New posts are in the works." ] ]

                                published ->
                                    [ div [ class "post-list" ] (List.map viewCard published) ]
                           )
                    )
                ]
            ]
        ]


viewCard : Post -> Html msg
viewCard post =
    a [ href ("/blog/" ++ post.slug), class "post-card" ]
        [ div [ class "post-meta" ]
            (time [ attribute "datetime" post.date ] [ text post.dateLabel ]
                :: List.map (\tag -> span [ class "tag" ] [ text tag ]) post.tags
            )
        , h2 [] [ text post.title ]
        , p [] [ text post.description ]
        , span [ class "read-more" ] [ text "Read →" ]
        ]


viewPost : Maybe Post -> Html msg
viewPost maybePost =
    div [ class "page-post" ]
        [ div [ id "container" ]
            [ main_ []
                [ article []
                    (a [ href "/blog", class "back" ] [ text "← Back to Blog" ]
                        :: (case maybePost of
                                Just post ->
                                    [ header [ class "post-header" ]
                                        [ div [ class "post-meta" ]
                                            (time [ attribute "datetime" post.date ] [ text post.dateLabel ]
                                                :: List.map (\tag -> span [ class "tag" ] [ text tag ]) post.tags
                                            )
                                        , h1 [] [ text post.title ]
                                        , p [ class "description" ] [ text post.description ]
                                        ]
                                    , node "post-body" [ class "prose", property "html" (Encode.string post.html) ] []
                                    ]

                                Nothing ->
                                    [ header [ class "post-header" ]
                                        [ h1 [] [ text "Post coming soon" ]
                                        , p [ class "description" ] [ text "This article is still being drafted. Check back shortly." ]
                                        ]
                                    ]
                           )
                    )
                ]
            ]
        ]
