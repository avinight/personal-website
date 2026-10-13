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
      , summary = "Backend/DevOps"
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
