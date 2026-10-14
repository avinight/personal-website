module Page.About exposing (view)

import Data.Bio as Bio exposing (Named, Social)
import Data.Education exposing (Education, education)
import Data.Experiences exposing (Experience, experiences)
import Html exposing (Html, a, div, h1, h2, h3, img, li, main_, p, section, span, text, ul)
import Html.Attributes exposing (alt, class, href, id, rel, src, target)
import Html.Lazy exposing (lazy, lazy2)
import Icon
import Rich


{-| `pulse` draws the ring that pulses on the newest entry of each timeline.
Everything else is drawn lazily, since the pulse redraws the page every
frame.
-}
view : { pulse : () -> Html msg } -> Html msg
view { pulse } =
    div [ class "page-about" ]
        [ div [ id "container" ]
            [ main_ []
                [ div [ id "content" ]
                    (h1 [] [ text "About Me" ]
                        :: List.map (\paragraph -> p [ class "intro" ] [ text paragraph ]) Bio.aboutIntro
                        ++ [ h2 [ class "section-heading" ] [ text "Experience" ]
                           , div [ class "timeline" ] (timeline pulse viewExperience experiences)
                           , h2 [ class "section-heading" ] [ text "Education" ]
                           , div [ class "timeline" ] (timeline pulse viewEducation education)
                           , h2 [ class "section-heading" ] [ text "Anime & Manga" ]
                           , viewAnime
                           , h2 [ class "section-heading" ] [ text "Socials" ]
                           , lazy viewSocials Bio.socials
                           ]
                    )
                ]
            ]
        ]


timeline : (() -> Html msg) -> (List (Html msg) -> a -> Html msg) -> List a -> List (Html msg)
timeline pulse viewEntry entries =
    List.indexedMap
        (\i entry ->
            if i == 0 then
                viewEntry [ pulse () ] entry

            else
                lazy2 viewEntry [] entry
        )
        entries


timelineEntry : List (Html msg) -> List (Html msg) -> Html msg
timelineEntry marker card =
    div [ class "timeline-entry" ]
        [ div [ class "timeline-marker" ] [ span [ class "dot" ] marker ]
        , section [ class "exp-card" ] card
        ]


viewExperience : List (Html msg) -> Experience -> Html msg
viewExperience marker exp =
    timelineEntry marker
        (List.concat
            [ [ div [ class "exp-header" ]
                    [ div [ class "exp-left" ]
                        (List.concat
                            [ case exp.logoUrl of
                                Just url ->
                                    [ div [ class "org-logo" ] [ img [ src url, alt exp.org ] [] ] ]

                                Nothing ->
                                    []
                            , [ div [ class "titles" ]
                                    [ h3 [] [ text exp.role ]
                                    , p [ class "org" ] [ text exp.org ]
                                    ]
                              ]
                            ]
                        )
                    , viewMeta exp.dates exp.location
                    ]
              , p [ class "summary" ] (Rich.view exp.summary)
              ]
            , if List.isEmpty exp.highlights then
                []

              else
                [ ul [ class "highlights" ] (List.map (\point -> li [] (Rich.view point)) exp.highlights) ]
            , if List.isEmpty exp.tech then
                []

              else
                [ div [ class "tags" ] (List.map viewTag exp.tech) ]
            ]
        )


viewEducation : List (Html msg) -> Education -> Html msg
viewEducation marker edu =
    timelineEntry marker
        (div [ class "exp-header" ]
            [ div [ class "titles" ]
                [ h3 [] [ text edu.degree ]
                , p [ class "org" ] [ text edu.institution ]
                ]
            , viewMeta edu.dates edu.location
            ]
            :: (if List.isEmpty edu.details then
                    []

                else
                    [ ul [ class "highlights" ] (List.map (\detail -> li [] [ text detail ]) edu.details) ]
               )
        )


viewMeta : String -> String -> Html msg
viewMeta dates location =
    div [ class "meta" ]
        [ span [ class "date" ] [ text dates ]
        , span [ class "location" ] [ text location ]
        ]


viewTag : Named -> Html msg
viewTag tag =
    span [ class "tag" ]
        [ span [ class "tag-icon" ] [ Icon.view tag.icon ]
        , span [ class "tag-name" ] [ text tag.name ]
        ]


viewAnime : Html msg
viewAnime =
    let
        card extraClass icon platform account =
            a
                [ href account.url
                , target "_blank"
                , rel "noopener noreferrer"
                , class ("anime-card " ++ extraClass)
                ]
                [ span [ class "anime-icon" ] [ Icon.view icon ]
                , div []
                    [ span [ class "anime-platform" ] [ text platform ]
                    , span [ class "anime-username" ] [ text ("@" ++ account.username) ]
                    ]
                ]
    in
    div [ class "anime-section" ]
        [ p [ class "anime-blurb" ] [ text "I track everything I watch and read. Find me on:" ]
        , div [ class "anime-links" ]
            [ card "anilist" "simple-icons:anilist" "AniList" Bio.anime.anilist
            , card "mal" "simple-icons:myanimelist" "MyAnimeList" Bio.anime.mal
            ]
        ]


viewSocials : List Social -> Html msg
viewSocials socials =
    div [ class "socials-section" ]
        [ if List.isEmpty socials then
            p [ class "socials-empty" ] [ text "More links coming soon." ]

          else
            div [ class "socials-links" ] (List.map viewSocial socials)
        ]


viewSocial : Social -> Html msg
viewSocial social =
    a [ href social.url, target "_blank", rel "noopener noreferrer", class "social-card" ]
        [ span [ class "social-icon" ] [ Icon.view social.icon ]
        , div []
            (span [ class "social-platform" ] [ text social.platform ]
                :: (case social.username of
                        Just username ->
                            [ span [ class "social-username" ] [ text ("@" ++ username) ] ]

                        Nothing ->
                            []
                   )
            )
        ]
