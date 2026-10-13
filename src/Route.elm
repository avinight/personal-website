module Route exposing (Route(..), fromUrl)

import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, oneOf, s, string, top)


type Route
    = Home
    | About
    | Projects
    | Blog
    | Post String
    | NotFound


parser : Parser (Route -> a) a
parser =
    oneOf
        [ Parser.map Home top
        , Parser.map About (s "about")
        , Parser.map Projects (s "projects")
        , Parser.map Blog (s "blog")
        , Parser.map Post (s "blog" </> string)
        ]


fromUrl : Url -> Route
fromUrl url =
    Maybe.withDefault NotFound (Parser.parse parser url)
