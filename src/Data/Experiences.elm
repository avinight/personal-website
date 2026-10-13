module Data.Experiences exposing (Experience, experiences)

{-| Work history for the About page. In `summary` and `highlights`,
`*text*` renders bold and `$tex$` renders as math.
-}

import Data.Bio exposing (Named)


type alias Experience =
    { role : String
    , org : String
    , location : String
    , dates : String
    , summary : String
    , highlights : List String
    , tech : List Named
    , logoUrl : Maybe String
    }


experiences : List Experience
experiences =
    [ { role = "Software Engineer Intern"
      , org = "TD Bank"
      , location = "Toronto, ON"
      , dates = "May 2026 - Present"
      , summary = "Backend/DevOps"
      , highlights = []
      , tech = [ Named "Python" "simple-icons:python" ]
      , logoUrl = Just "/logos/Toronto-Dominion_Bank_logo.svg"
      }
    , { role = "Student Researcher"
      , org = "University of Toronto"
      , location = "Toronto, ON"
      , dates = "January 2026 - April 2026"
      , summary = "Applying the winding number optimization to build an inside-outside indicator function for a Gaussian splat under supervision of Prof. David Levin."
      , highlights = []
      , tech = [ Named "Python" "simple-icons:python" ]
      , logoUrl = Just "/logos/Utoronto_coa.svg"
      }
    , { role = "Software Developer Intern"
      , org = "Knowlecy Technologies Inc."
      , location = "Vancouver, BC (Remote)"
      , dates = "January 2025 - May 2025"
      , summary = "Built core features in a *retrieval augmented generation (RAG)* chat application using *React* and *Neo4j*"
      , highlights =
            [ "Eliminated *10+* critical rendering bottlenecks, reducing UI latency and improving application stability."
            , "Enabled *persistent state management* functionality, enhancing user navigation and live feedback loops."
            ]
      , tech =
            [ Named "React" "simple-icons:react"
            , Named "TypeScript" "simple-icons:typescript"
            , Named "Neo4j" "simple-icons:neo4j"
            ]
      , logoUrl = Just "/logos/Knowlecy_logo.svg"
      }
    ]
