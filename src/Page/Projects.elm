module Page.Projects exposing (view)

import Data.Bio exposing (Named)
import Data.Projects exposing (Description(..), Project, projects)
import Html exposing (Html, a, div, h1, h2, li, main_, p, span, text, ul)
import Html.Attributes exposing (class, href, id, rel, target)
import Icon
import Rich


view : Html msg
view =
    div [ class "page-projects" ]
        [ div [ class "page-container" ]
            [ main_ []
                [ div [ class "page-column" ]
                    [ h1 [] [ text "My Projects" ]
                    , p [ class "intro" ] [ text "Here are some of the cool projects I've been working on." ]
                    , div [ class "projects-grid" ] (List.map viewProject projects)
                    ]
                ]
            ]
        ]


viewProject : Project -> Html msg
viewProject project =
    div [ class "project-card" ]
        (List.concat
            [ [ h2 [] [ text project.title ]
              , case project.description of
                    Paragraph body ->
                        p [] (Rich.view body)

                    Bullets items ->
                        ul [ class "description-list" ] (List.map (\item -> li [] (Rich.view item)) items)
              ]
            , if List.isEmpty project.tags then
                []

              else
                [ div [ class "tags" ] (List.map viewTag project.tags) ]
            , [ div [ class "project-links" ]
                    (List.filterMap identity
                        [ Maybe.map (projectLink "lucide:external-link" "View Demo") project.demoUrl
                        , Maybe.map (projectLink "lucide:github" "Source Code") project.sourceUrl
                        ]
                    )
              ]
            ]
        )


viewTag : Named -> Html msg
viewTag tag =
    span [ class "tag" ]
        [ span [ class "tag-icon" ] [ Icon.view tag.icon ]
        , span [ class "tag-name" ] [ text tag.name ]
        ]


projectLink : String -> String -> String -> Html msg
projectLink icon label url =
    a [ href url, target "_blank", rel "noopener noreferrer" ]
        [ span [ class "link-icon" ] [ Icon.view icon ]
        , span [] [ text label ]
        ]
