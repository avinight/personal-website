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
    [ "I am obsessed with health, technology, and learning. In my free time, I love going to the gym, climbing, playing instruments, and watching politics!"
    , "Below are some places I've worked and studied."
    ]


about : List String
about =
    [ "I am a software engineer, mathematics enthusiast, and lifelong learner. I am passionate about building efficient and scalable systems that solve real-world problems."
    , "I have research interests in data structure optimization, high performance computing, and computer graphics."
    , "When I am not programming, I enjoy exploring the world through learning new languages, reading books, rock climbing, and playing piano."
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
        , Named "Java" "simple-icons:oracle"
        , Named "C++" "simple-icons:cplusplus"
        , Named "C" "simple-icons:c"
        , Named "Zig" "simple-icons:zig"
        , Named "SQL" "simple-icons:mysql"
        , Named "JavaScript" "simple-icons:javascript"
        , Named "TypeScript" "simple-icons:typescript"
        , Named "Haskell" "simple-icons:haskell"
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
