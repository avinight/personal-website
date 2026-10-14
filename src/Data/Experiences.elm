module Data.Experiences exposing (Experience, experiences)

{-| Work history for the About page. In `summary` and `highlights`,
`*text*` renders bold, `$tex$` renders as math and `[text](url)` is a link.
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
      , dates = "May 2026 - August 2026"
      , summary = "DevSecOps on the Pipelines and Platforms team."
      , highlights =
            [ "Resolved “Argument list too long” CI/CD failures blocking deployments across multiple LoBs by redesigning the GitHub Actions env payload from $O(n^2)$ to $O(n)$, bringing it under the *128 KiB* env-var limit."
            , "Built an interactive *Power BI* audit sourced from *Datadog*, surfacing per-LoB CI/CD health (active app codes, build/job success rates, median deploy time, prod deploy volume) to support an active audit, reviewed at the *VP/SVP* level."
            , "Refactored a YAML→Jenkins config seeding plugin, consolidating *4* duplicated, tightly coupled flows into one testable module designed to serve CI/CD for *3750+* app codes, removing config duplication across flows."
            , "Audited cross-team production infrastructure dependencies to assess compliance risks and unblock environment migration."
            , "Built an [agentic mobile banking PoC](https://aelnimah.github.io/SideKick/demo.html) with shoulder-surfing/camera detection and per-device public-key authentication."
            ]
      , tech = [ Named "Python" "simple-icons:python" ]
      , logoUrl = Just "/logos/Toronto-Dominion_Bank_logo.svg"
      }
    , { role = "Student Researcher"
      , org = "University of Toronto"
      , location = "Toronto, ON"
      , dates = "January 2026 - April 2026"
      , summary = "VoxSeG: A post-processing pipeline for 3D geometry recovery from Gaussian Splats, supervised by Prof. David Levin who helped us refine the idea."
      , highlights = []
      , tech = [ Named "Python" "simple-icons:python" ]
      , logoUrl = Just "/logos/Utoronto_coa.svg"
      }
    , { role = "Software Developer Intern"
      , org = "Knowlecy Technologies Inc."
      , location = "Vancouver, BC (Remote)"
      , dates = "January 2025 - May 2025"
      , summary = "A *retrieval augmented generation (RAG)* chat application that helps researchers collaborate and synthesize papers with AI."
      , highlights =
            [ "I added features and performance upgrades to application's read and write functionality."
            ]
      , tech =
            [ Named "React" "simple-icons:react"
            , Named "TypeScript" "simple-icons:typescript"
            , Named "Neo4j" "simple-icons:neo4j"
            ]
      , logoUrl = Just "/logos/Knowlecy_logo.svg"
      }
    ]
