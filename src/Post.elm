module Post exposing (Post, decoder, find, published)

{-| Blog posts come from content/blog/*.md. Markdown and math are rendered to
HTML at build time (scripts/vite-plugin-blog.js) and passed in as flags.
-}

import Json.Decode as Decode exposing (Decoder)


type alias Post =
    { slug : String
    , title : String
    , date : String
    , dateLabel : String
    , description : String
    , tags : List String
    , draft : Bool
    , html : String
    }


decoder : Decoder Post
decoder =
    Decode.map8 Post
        (Decode.field "slug" Decode.string)
        (Decode.field "title" Decode.string)
        (Decode.field "date" Decode.string)
        (Decode.field "dateLabel" Decode.string)
        (Decode.field "description" Decode.string)
        (Decode.field "tags" (Decode.list Decode.string))
        (Decode.field "draft" Decode.bool)
        (Decode.field "html" Decode.string)


published : List Post -> List Post
published =
    List.filter (not << .draft)


find : String -> List Post -> Maybe Post
find slug posts =
    published posts
        |> List.filter (\post -> post.slug == slug)
        |> List.head
