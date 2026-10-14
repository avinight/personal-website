module Data.Bio exposing
    ( Account
    , IconGroup
    , Named
    , Social
    , about
    , aboutIntro
    , anime
    , greeting
    , languages
    , socials
    , techStack
    , activeInterests
    )

{-| Personal details shown on the Home and About pages. Icon names are
Iconify ids; run `npm run icons` after adding a new one.
-}


type alias Named =
    { name : String
    , icon : String
    }


type alias IconGroup =
    { heading : String
    , items : List Named
    }


type alias Account =
    { username : String
    , url : String
    }


type alias Social =
    { platform : String
    , url : String
    , icon : String
    , username : Maybe String
    }


greeting : String
greeting =
    "Hi, I'm Frederick!"


aboutIntro : List String
aboutIntro =
    [ "I have a mild interest in living and in my free time, I read, gym, and climb." ]


about : List String
about =
    [ "I am a software engineer and computer scientist by trade and an artist for fun."
    , "I have research interests in data structure optimization, high performance computing, and computer graphics."
    , "I love to explore the world, express myself creatively through music, and participate in social activities and sports."
    ]

activeInterests : List String
activeInterests =
    [ "Active Interests"
    , "Currently I'm learning Rust, Lean4, and to reconnect with my soul."
    , "I also enjoy knowledge from other domains like philosophy, medicine, and neuroscience "
    ]

anime : { anilist : Account, mal : Account }
anime =
    { anilist = { username = "AviNight", url = "https://anilist.co/user/AviNight/" }
    , mal = { username = "AviNight", url = "https://myanimelist.net/profile/AviNight" }
    }


techStack : IconGroup
techStack =
    { heading = "Tech Stack"
    , items =
        [ Named "Python" "simple-icons:python"
        , Named "Java" "simple-icons:openjdk"
        , Named "C++" "simple-icons:cplusplus"
        , Named "C" "simple-icons:c"
        , Named "Zig" "simple-icons:zig"
        , Named "TypeScript" "simple-icons:typescript"
        , Named "Haskell" "simple-icons:haskell"
        , Named "Rust" "simple-icons:rust"
        ]
    }


languages : IconGroup
languages =
    { heading = "Languages"
    , items =
        [ Named "English" "twemoji:flag-united-states"
        , Named "French" "twemoji:flag-france"
        , Named "Tagalog" "twemoji:flag-philippines"
        , Named "Japanese" "twemoji:flag-japan"
        ]
    }


socials : List Social
socials =
    [ Social "Linktree" "https://linktr.ee/_.friedrice" "simple-icons:linktree" (Just "_.friedrice")
    , Social "Devpost" "https://devpost.com/avinight" "simple-icons:devpost" (Just "avinight")
    , Social "Hevy" "https://hevy.com/user/friedricemm" "lucide:dumbbell" (Just "friedricemm")
    ]
