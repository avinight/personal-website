port module Main exposing (main)

import Backdrop
import Browser
import Browser.Dom
import Browser.Navigation as Nav
import Data.Bio as Bio
import Html exposing (Html, a, button, div, footer, header, img, nav, p, span, text)
import Html.Attributes exposing (alt, attribute, class, href, id, rel, src, target)
import Html.Events exposing (onClick)
import Html.Keyed
import Http
import Icon
import Json.Decode as Decode
import Logo
import Page.About
import Page.Blog
import Page.Home
import Page.NotFound
import Page.Projects
import Post exposing (Post)
import Route exposing (Route)
import Task
import Time
import Url exposing (Url)


main : Program Decode.Value Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


-- Remembers the theme and sets the `dark` class on the page (see main.js).


port saveTheme : String -> Cmd msg



-- MODEL


type Theme
    = Light
    | Dark


type alias Model =
    { key : Nav.Key
    , route : Route
    , theme : Theme
    , year : Int
    , posts : List Post
    , visitors : Maybe Int
    , reducedMotion : Bool
    , typed : Int
    , logo : Logo.Model
    , backdrop : Backdrop.Model
    }


type alias Flags =
    { theme : String
    , year : Int
    , newVisitor : Bool
    , reducedMotion : Bool
    , posts : List Post
    }


flagsDecoder : Decode.Decoder Flags
flagsDecoder =
    Decode.map5 Flags
        (Decode.field "theme" Decode.string)
        (Decode.field "year" Decode.int)
        (Decode.field "newVisitor" Decode.bool)
        (Decode.field "reducedMotion" Decode.bool)
        (Decode.field "posts" (Decode.list Post.decoder))


defaultFlags : Flags
defaultFlags =
    { theme = "dark", year = 2026, newVisitor = False, reducedMotion = False, posts = [] }


init : Decode.Value -> Url -> Nav.Key -> ( Model, Cmd Msg )
init json url key =
    let
        flags =
            Decode.decodeValue flagsDecoder json
                |> Result.withDefault defaultFlags
    in
    ( { key = key
      , route = Route.fromUrl url
      , theme =
            if flags.theme == "light" then
                Light

            else
                Dark
      , year = flags.year
      , posts = flags.posts
      , visitors = Nothing
      , reducedMotion = flags.reducedMotion
      , typed = startTyping flags.reducedMotion
      , logo = Logo.init flags.reducedMotion
      , backdrop = Backdrop.init flags.reducedMotion
      }
    , fetchVisitors flags.newVisitor
    )


startTyping : Bool -> Int
startTyping reducedMotion =
    if reducedMotion then
        String.length Bio.greeting

    else
        0


fetchVisitors : Bool -> Cmd Msg
fetchVisitors newVisitor =
    Http.get
        { url =
            if newVisitor then
                "/api/visitors?up=1"

            else
                "/api/visitors"
        , expect = Http.expectJson GotVisitors (Decode.field "count" (Decode.nullable Decode.int))
        }



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url
    | ToggleTheme
    | GotVisitors (Result Http.Error (Maybe Int))
    | TypeTick Time.Posix
    | LogoMsg Logo.Msg
    | BackdropMsg Backdrop.Msg
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked (Browser.Internal url) ->
            ( model, Nav.pushUrl model.key (Url.toString url) )

        LinkClicked (Browser.External url) ->
            ( model, Nav.load url )

        UrlChanged url ->
            let
                route =
                    Route.fromUrl url
            in
            if route == model.route then
                ( model, Cmd.none )

            else
                ( { model
                    | route = route
                    , typed =
                        if route == Route.Home then
                            startTyping model.reducedMotion

                        else
                            model.typed
                  }
                , Task.perform (\_ -> NoOp) (Browser.Dom.setViewport 0 0)
                )

        ToggleTheme ->
            let
                theme =
                    if model.theme == Dark then
                        Light

                    else
                        Dark
            in
            ( { model | theme = theme }, saveTheme (themeName theme) )

        GotVisitors result ->
            ( { model | visitors = Result.withDefault Nothing result }, Cmd.none )

        TypeTick _ ->
            ( { model | typed = model.typed + 1 }, Cmd.none )

        LogoMsg logoMsg ->
            ( { model | logo = Logo.update logoMsg model.logo }, Cmd.none )

        BackdropMsg backdropMsg ->
            ( { model | backdrop = Backdrop.update backdropMsg model.backdrop }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


themeName : Theme -> String
themeName theme =
    case theme of
        Light ->
            "light"

        Dark ->
            "dark"


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map BackdropMsg (Backdrop.subscriptions model.backdrop)
        , if model.route == Route.Home then
            Sub.batch
                [ Sub.map LogoMsg (Logo.subscriptions model.logo)
                , if model.typed < String.length Bio.greeting then
                    Time.every 90 TypeTick

                  else
                    Sub.none
                ]

          else
            Sub.none
        ]



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = title model.route
    , body =
        [ img [ id "bg-image", src "/background.svg", alt "", attribute "fetchpriority" "high" ] []
        , div [ id "bg-overlay" ] []
        , Backdrop.view model.backdrop
        , div [ id "page-content" ]
            [ viewHeader model
            , Html.Keyed.node "div"
                [ class "page-frame" ]
                [ ( pageKey model.route, viewPage model ) ]
            , viewFooter model
            ]
        ]
    }


title : Route -> String
title route =
    let
        site =
            "Frederick Meneses - Software Engineer"
    in
    case route of
        Route.Home ->
            site

        Route.About ->
            "About · " ++ site

        Route.Projects ->
            "Projects · " ++ site

        Route.Blog ->
            "Blog · " ++ site

        Route.Post _ ->
            "Blog · " ++ site

        Route.NotFound ->
            "Not found · " ++ site


{-| A new key per page makes the page fade in when you navigate.
-}
pageKey : Route -> String
pageKey route =
    case route of
        Route.Home ->
            "home"

        Route.About ->
            "about"

        Route.Projects ->
            "projects"

        Route.Blog ->
            "blog"

        Route.Post slug ->
            "post/" ++ slug

        Route.NotFound ->
            "not-found"


viewPage : Model -> Html Msg
viewPage model =
    case model.route of
        Route.Home ->
            Page.Home.view
                { typed = model.typed
                , logo = Html.map LogoMsg (Logo.view model.logo)
                }

        Route.About ->
            Page.About.view

        Route.Projects ->
            Page.Projects.view

        Route.Blog ->
            Page.Blog.viewList model.posts

        Route.Post slug ->
            Page.Blog.viewPost (Post.find slug model.posts)

        Route.NotFound ->
            Page.NotFound.view


viewHeader : Model -> Html Msg
viewHeader model =
    let
        navLink path label isCurrent =
            a
                (href path
                    :: (if isCurrent then
                            [ attribute "aria-current" "page" ]

                        else
                            []
                       )
                )
                [ text label ]

        isBlog =
            case model.route of
                Route.Blog ->
                    True

                Route.Post _ ->
                    True

                _ ->
                    False
    in
    header [ class "site-header" ]
        [ div [ class "container" ]
            [ div [ class "profile-section" ]
                [ a
                    [ class "avatar-link"
                    , href "https://github.com/avinight"
                    , target "_blank"
                    , rel "noopener noreferrer"
                    , attribute "aria-label" "GitHub profile"
                    ]
                    [ img [ src "/bucchi.png", alt "Profile Picture", class "avatar-img" ] []
                    , span [ class "avatar-badge" ] [ Icon.view "simple-icons:github" ]
                    ]
                , span [ class "profile-name" ] [ text "Frederick Meneses" ]
                ]
            , nav [ class "header-nav" ]
                [ navLink "/" "Home" (model.route == Route.Home)
                , navLink "/about" "About" (model.route == Route.About)
                , navLink "/projects" "Projects" (model.route == Route.Projects)
                , navLink "/blog" "Blog" isBlog
                , button
                    [ class "theme-toggle"
                    , attribute "aria-label" "Toggle theme"
                    , onClick ToggleTheme
                    ]
                    [ text
                        (if model.theme == Dark then
                            "☀️"

                         else
                            "🌙"
                        )
                    ]
                ]
            ]
        ]


viewFooter : Model -> Html Msg
viewFooter model =
    let
        social url label icon =
            a [ href url, target "_blank", rel "noopener noreferrer", attribute "aria-label" label ]
                [ Icon.view icon ]
    in
    footer [ class "footer" ]
        [ a
            [ href "https://www.buymeacoffee.com/friedrice"
            , target "_blank"
            , rel "noopener noreferrer"
            , class "matcha-btn"
            ]
            [ img
                [ src "https://img.buymeacoffee.com/button-api/?text=Buy me a matcha&emoji=🍵&slug=friedrice&button_colour=1e8525&font_colour=ffffff&font_family=Bree&outline_colour=ffffff&coffee_colour=FFDD00"
                , alt "Buy me a matcha"
                ]
                []
            ]
        , div [ class "footer-center" ]
            [ div [ class "social-links" ]
                [ social "https://github.com/avinight" "GitHub" "simple-icons:github"
                , social "https://linkedin.com/in/friedrice123" "LinkedIn" "simple-icons:linkedin"
                , social "https://instagram.com/_.friedrice" "Instagram" "simple-icons:instagram"
                , a [ href "mailto:friedricemm@gmail.com", attribute "aria-label" "Email" ]
                    [ Icon.view "lucide:mail" ]
                ]
            , p [] [ text ("© " ++ String.fromInt model.year ++ " Frederick Meneses. All rights reserved.") ]
            ]
        , div [ class "visitor-count" ]
            [ Icon.viewWith "visitors-icon" "lucide:users"
            , div [ class "visitors-text" ]
                [ span [ id "visitor-num" ]
                    [ text (Maybe.withDefault "—" (Maybe.map formatCount model.visitors)) ]
                , span [ class "visitors-label" ] [ text "visitors" ]
                ]
            ]
        ]


{-| 12345 -> "12,345"
-}
formatCount : Int -> String
formatCount n =
    let
        group digits =
            if String.length digits <= 3 then
                digits

            else
                group (String.dropRight 3 digits) ++ "," ++ String.right 3 digits
    in
    if n < 0 then
        "-" ++ group (String.fromInt (abs n))

    else
        group (String.fromInt n)
