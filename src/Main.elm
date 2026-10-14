port module Main exposing (main)

import Backdrop
import Browser
import Browser.Dom
import Browser.Events
import Browser.Navigation as Nav
import Data.Bio as Bio
import Decor
import Html exposing (Html, a, button, div, footer, header, img, nav, p, span, text)
import Html.Attributes exposing (alt, attribute, class, height, href, id, rel, src, target, width)
import Html.Events exposing (onClick)
import Html.Keyed
import Html.Lazy exposing (lazy, lazy2)
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


-- Tells Elm when the visitor turns reduced motion on or off (see main.js).


port reducedMotionChanged : (Bool -> msg) -> Sub msg



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
    , screen : Backdrop.Screen
    , backdrop : Backdrop.Model
    , caretAge : Float
    , pulseClock : Float
    }


type alias Flags =
    { theme : String
    , year : Int
    , newVisitor : Bool
    , reducedMotion : Bool
    , posts : List Post
    , screen : Backdrop.Screen
    }


flagsDecoder : Decode.Decoder Flags
flagsDecoder =
    Decode.map6 Flags
        (Decode.field "theme" Decode.string)
        (Decode.field "year" Decode.int)
        (Decode.field "newVisitor" Decode.bool)
        (Decode.field "reducedMotion" Decode.bool)
        (Decode.field "posts" (Decode.list Post.decoder))
        (Decode.field "screen" screenDecoder)


screenDecoder : Decode.Decoder Backdrop.Screen
screenDecoder =
    Decode.map3 Backdrop.Screen
        (Decode.field "width" Decode.float)
        (Decode.field "height" Decode.float)
        (Decode.field "pixelRatio" Decode.float)


defaultFlags : Flags
defaultFlags =
    { theme = "dark"
    , year = 2026
    , newVisitor = False
    , reducedMotion = False
    , posts = []
    , screen = { width = 0, height = 0, pixelRatio = 1 }
    }


init : Decode.Value -> Url -> Nav.Key -> ( Model, Cmd Msg )
init json url key =
    let
        flags =
            Decode.decodeValue flagsDecoder json
                |> Result.withDefault defaultFlags

        theme =
            if flags.theme == "light" then
                Light

            else
                Dark
    in
    ( { key = key
      , route = Route.fromUrl url
      , theme = theme
      , year = flags.year
      , posts = flags.posts
      , visitors = Nothing
      , reducedMotion = flags.reducedMotion
      , typed = startTyping flags.reducedMotion
      , logo = Logo.init { reducedMotion = flags.reducedMotion, dark = theme == Dark }
      , screen = flags.screen
      , backdrop = Backdrop.init
      , caretAge = 0
      , pulseClock = 0
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
    | MouseMoved Float Float Backdrop.Screen
    | Resized
    | GotViewport Browser.Dom.Viewport
    | ReducedMotionChanged Bool
    | DecorFrame Float
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
                    , caretAge =
                        if route == Route.Home then
                            0

                        else
                            model.caretAge
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
            ( { model
                | theme = theme
                , logo = Logo.setDark (model.route == Route.Home) (theme == Dark) model.logo
              }
            , saveTheme (themeName theme)
            )

        GotVisitors result ->
            ( { model | visitors = Result.withDefault Nothing result }, Cmd.none )

        TypeTick _ ->
            ( { model | typed = model.typed + 1 }, Cmd.none )

        LogoMsg logoMsg ->
            ( { model | logo = Logo.update logoMsg model.logo }, Cmd.none )

        BackdropMsg backdropMsg ->
            ( { model | backdrop = Backdrop.update backdropMsg model.backdrop }, Cmd.none )

        MouseMoved x y window ->
            let
                screen =
                    model.screen
            in
            ( { model
                | backdrop = Backdrop.lookAt (x / window.width * 2 - 1) (y / window.height * 2 - 1) model.backdrop
                , screen = { screen | pixelRatio = window.pixelRatio }
              }
            , Cmd.none
            )

        Resized ->
            ( model, Task.perform GotViewport Browser.Dom.getViewport )

        GotViewport { viewport } ->
            let
                screen =
                    model.screen
            in
            ( { model | screen = { screen | width = viewport.width, height = viewport.height } }, Cmd.none )

        DecorFrame delta ->
            case model.route of
                Route.Home ->
                    ( { model | caretAge = model.caretAge + delta }, Cmd.none )

                Route.About ->
                    ( { model | pulseClock = model.pulseClock + delta }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        ReducedMotionChanged reducedMotion ->
            ( { model | reducedMotion = reducedMotion }, Cmd.none )

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
        [ Sub.map BackdropMsg (Backdrop.subscriptions model.reducedMotion)
        , Browser.Events.onMouseMove mouseDecoder
        , Browser.Events.onResize (\_ _ -> Resized)
        , reducedMotionChanged ReducedMotionChanged
        , case model.route of
            Route.Home ->
                Sub.batch
                    [ Sub.map LogoMsg (Logo.subscriptions model.logo)
                    , if typing model then
                        Time.every 90 TypeTick

                      else if not model.reducedMotion && model.caretAge < Decor.caretLife then
                        Browser.Events.onAnimationFrameDelta DecorFrame

                      else
                        Sub.none
                    ]

            Route.About ->
                if model.reducedMotion then
                    Sub.none

                else
                    Browser.Events.onAnimationFrameDelta DecorFrame

            _ ->
                Sub.none
        ]


typing : Model -> Bool
typing model =
    model.typed < String.length Bio.greeting


{-| Where the mouse is, and the window it is in. Zooming changes the device
pixel ratio, which Elm can't otherwise read, so it is picked up here too.
-}
mouseDecoder : Decode.Decoder Msg
mouseDecoder =
    Decode.map3 MouseMoved
        (Decode.field "clientX" Decode.float)
        (Decode.field "clientY" Decode.float)
        (Decode.field "view" screenDecoderFromWindow)


screenDecoderFromWindow : Decode.Decoder Backdrop.Screen
screenDecoderFromWindow =
    Decode.map3 Backdrop.Screen
        (Decode.field "innerWidth" Decode.float)
        (Decode.field "innerHeight" Decode.float)
        (Decode.field "devicePixelRatio" Decode.float)



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = title model.route
    , body =
            [ div [ id "bg-overlay" ] []
            , Backdrop.view model.screen (model.theme == Dark) model.backdrop
            , div [ id "page-content" ]
                [ lazy2 viewHeader model.route model.theme
                , Html.Keyed.node "div"
                    [ class "page-frame" ]
                    [ ( pageKey model.route, viewPage model ) ]
                , lazy2 viewFooter model.year model.visitors
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


{-| The home page's logo redraws the page every frame, so everything that
isn't animated is wrapped in `lazy` and only rebuilt when its inputs change.
-}
viewPage : Model -> Html Msg
viewPage model =
    case model.route of
        Route.Home ->
            Page.Home.view
                { typed = model.typed
                , caret =
                    Decor.caret (model.theme == Dark)
                        (Decor.caretVisible
                            (if typing model then
                                Nothing

                             else
                                Just model.caretAge
                            )
                        )
                , logo = Html.map LogoMsg (Logo.view (logoPixels model.screen) model.logo)
                }

        Route.About ->
            Page.About.view
                { pulse =
                    \() ->
                        Decor.pulse model.screen.pixelRatio
                            (model.theme == Dark)
                            (if model.reducedMotion then
                                Nothing

                             else
                                Just model.pulseClock
                            )
                }

        _ ->
            lazy2 viewStaticPage model.route model.posts


{-| The logo is `clamp(96px, 18vw, 150px)` across (see logo.css), and its
canvas is twice that.
-}
logoPixels : Backdrop.Screen -> Int
logoPixels screen =
    round (clamp 96 150 (screen.width * 0.18) * 2 * min 2 screen.pixelRatio)


viewStaticPage : Route -> List Post -> Html Msg
viewStaticPage route posts =
    case route of
        Route.Home ->
            -- Drawn by viewPage, since the logo is animated.
            text ""

        Route.About ->
            -- Drawn by viewPage, since the timeline pulses.
            text ""

        Route.Projects ->
            Page.Projects.view

        Route.Blog ->
            Page.Blog.viewList posts

        Route.Post slug ->
            Page.Blog.viewPost (Post.find slug posts)

        Route.NotFound ->
            Page.NotFound.view


viewHeader : Route -> Theme -> Html Msg
viewHeader route theme =
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
            case route of
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
                    [ img [ src "/bucchi-avatar.webp", alt "Profile Picture", class "avatar-img", width 50, height 50 ] []
                    , span [ class "avatar-badge" ] [ Icon.view "simple-icons:github" ]
                    ]
                , span [ class "profile-name" ] [ text "Frederick Meneses" ]
                ]
            , nav [ class "header-nav" ]
                [ navLink "/" "Home" (route == Route.Home)
                , navLink "/about" "About" (route == Route.About)
                , navLink "/projects" "Projects" (route == Route.Projects)
                , navLink "/blog" "Blog" isBlog
                , button
                    [ class "theme-toggle"
                    , attribute "aria-label" "Toggle theme"
                    , onClick ToggleTheme
                    ]
                    [ text
                        (if theme == Dark then
                            "☀️"

                         else
                            "🌙"
                        )
                    ]
                ]
            ]
        ]


viewFooter : Int -> Maybe Int -> Html Msg
viewFooter year visitors =
    let
        social url label icon =
            a [ href url, target "_blank", rel "noopener noreferrer", attribute "aria-label" label ]
                [ Icon.view icon ]
    in
    footer [ class "footer" ]
        [ div [] []
        -- [ a
        --     [ href "https://www.buymeacoffee.com/friedrice"
        --     , target "_blank"
        --     , rel "noopener noreferrer"
        --     , class "matcha-btn"
        --     ]
        --     [ img
        --         [ src "https://img.buymeacoffee.com/button-api/?text=Buy me a matcha&emoji=🍵&slug=friedrice&button_colour=1e8525&font_colour=ffffff&font_family=Bree&outline_colour=ffffff&coffee_colour=FFDD00"
        --         , alt "Buy me a matcha"
        --         ]
        --         []
        --     ]
        , div [ class "footer-center" ]
            [ div [ class "social-links" ]
                [ social "https://github.com/avinight" "GitHub" "simple-icons:github"
                , social "https://www.linkedin.com/in/frederick-meneses/" "LinkedIn" "simple-icons:linkedin"
                , social "https://instagram.com/_.friedrice" "Instagram" "simple-icons:instagram"
                , a [ href "mailto:friedricemm@gmail.com", attribute "aria-label" "Email" ]
                    [ Icon.view "lucide:mail" ]
                ]
            , p [] [ text ("© " ++ String.fromInt year ++ " Frederick Meneses. All rights reserved.") ]
            ]
        , div [ class "visitor-count" ]
            [ Icon.viewWith "visitors-icon" "lucide:users"
            , div [ class "visitors-text" ]
                [ span [ id "visitor-num" ]
                    [ text (Maybe.withDefault "—" (Maybe.map formatCount visitors)) ]
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
