module Data.Projects exposing (Description(..), Project, projects)

{-| Projects page entries. In descriptions, `*text*` renders bold and
`$tex$` renders as math. Icon names come from Simple Icons
(<https://icon-sets.iconify.design/simple-icons/>).
-}

import Data.Bio exposing (Named)


type Description
    = Paragraph String
    | Bullets (List String)


type alias Project =
    { title : String
    , description : Description
    , demoUrl : Maybe String
    , sourceUrl : Maybe String
    , tags : List Named
    }


projects : List Project
projects =
    [ { title = "Sphinx: Succinct Perfect Hash Index on ARM"
      , description = Paragraph "Ported succinct perfect hash index (Sphinx, VLDB '25) from x86 to ARM: implemented zp7 pext polyfill + vertical SIMD batching achieving *4.83×* speedup over scalar baseline on Apple M1 and *2.29×* speedup on x86."
      , demoUrl = Nothing
      , sourceUrl = Just "https://pdflink.to/ee0ce3de/"
      , tags =
            [ Named "C++" "simple-icons:cplusplus"
            , Named "ARM" "simple-icons:arm"
            ]
      }
    , { title = "VoxSeG: Geometry Recovery From Gaussian Splats"
      , description =
            Bullets
                [ "A post-processing pipeline for 3D geometry recovery from Gaussian Splats, evaluated across 5 scenes; submitted to SIGGRAPH '26."
                , "Optimized a $128^3$ voxel grid (~2 million voxels) with convergence in just 50 iterations. Supervised by Prof. David Levin."
                ]
      , demoUrl = Nothing
      , sourceUrl = Just "https://github.com/JeremyXie123/CSC494"
      , tags =
            [ Named "Python" "simple-icons:python"
            , Named "CUDA" "simple-icons:nvidia"
            ]
      }
    , { title = "Search Engine Project"
      , description =
            Bullets
                [ "*Led* a *6-person* team for the development of a B2B real-time search engine application with full-text NLP-based query matching and semantic relevance via embedding similarity, using *agile* methodologies."
                , "Implemented user feedback loops (ratings, citations) and *AI-generated* summaries, integrating *React* components with *Neo4j*, resulting in improved data tagging for the *RAG* pipeline."
                , "Scaled to *10,000+* papers and *500+* daily searches, *<1* second query latency with *microservice* architecture, *Neo4j* indexing, and *Docker/AWS* back-end, *Vercel* front-end deployment."
                ]
      , demoUrl = Just "https://www.youtube.com/watch?v=L-2fCBj8h5w&feature=youtu.be"
      , sourceUrl = Just "https://csc301-2024-f.github.io/search-frontend/index.html"
      , tags =
            [ Named "React" "simple-icons:react"
            , Named "TypeScript" "simple-icons:typescript"
            , Named "PostgreSQL" "simple-icons:postgresql"
            ]
      }
    , { title = "Student Response Classifier"
      , description = Paragraph "*Led* a *4-person* team to train Naive Bayes, Random Forest, and Neural Network classifiers using TF-IDF, achieving *95%* validation accuracy using *500* trees."
      , demoUrl = Nothing
      , sourceUrl = Just "https://github.com/David1425/CSC311_project"
      , tags =
            [ Named "Python" "simple-icons:python"
            , Named "Pandas" "simple-icons:pandas"
            , Named "Scikit-learn" "simple-icons:scikitlearn"
            ]
      }
    , { title = "KVStore Database"
      , description = Paragraph "A Tiered Log Structured Merge (LSM) Tree implementation in Zig for write optimized workloads using a *ZipTree/SkipList* Memtable. Inspired by *Cassandra*, *Tigerbeetle*, and *RocksDB*."
      , demoUrl = Nothing
      , sourceUrl = Nothing
      , tags = [ Named "Zig" "simple-icons:zig" ]
      }
    , { title = "Archive Management Tool"
      , description = Paragraph "A custom archive management tool (“kar”) from scratch, capable of creating and extracting archives with recursive directory support, modeled after UNIX tar utility. Implemented efficient memory management with Valgrind to eliminate leaks, handling multiple linked list directory data structures."
      , demoUrl = Nothing
      , sourceUrl = Just "https://github.com/avinight/kar-archive-tool"
      , tags =
            [ Named "C" "simple-icons:c"
            , Named "Bash" "simple-icons:gnubash"
            ]
      }
    , { title = "FoodBar"
      , description =
            Bullets
                [ "*Co-led* a *7-person* team to develop a social media app for cooking enthusiasts, enabling users to post, search, and share recipes with features like ingredient filtering, serving size adjustment, and recipe saving in *Java*."
                , "Followed *SOLID* design principles and adhered to *Clean Architecture*. Implemented user-driven functionalities, including user registration, interactive recipe reviews, and dynamic content filtering by cuisine or popularity."
                ]
      , demoUrl = Nothing
      , sourceUrl = Just "https://github.com/avinight/Foodbar"
      , tags =
            [ Named "Java" "simple-icons:oracle"
            , Named "Mongo" "simple-icons:mongodb"
            , Named "Gradle" "simple-icons:gradle"
            , Named "Android Studio" "simple-icons:androidstudio"
            ]
      }
    , { title = "MIPS Breakout Assembly"
      , description = Paragraph "Used *MIPS Assembly* to implement a working version of the game Breakout."
      , demoUrl = Nothing
      , sourceUrl = Just "https://github.com/avinight/breakout"
      , tags = [ Named "Assembly" "simple-icons:gnu" ]
      }
    , { title = "Haskell Interpreter"
      , description = Paragraph "Implemented a Haskell interpreter to understand functional programming."
      , demoUrl = Nothing
      , sourceUrl = Nothing
      , tags = [ Named "Haskell" "simple-icons:haskell" ]
      }
    ]
