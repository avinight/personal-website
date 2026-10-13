module Data.Education exposing (Education, education)


type alias Education =
    { degree : String
    , institution : String
    , location : String
    , dates : String
    , details : List String
    }


education : List Education
education =
    [ { degree = "Honours Bachelor of Science — Computer Science"
      , institution = "University of Toronto"
      , location = "Toronto, ON"
      , dates = "2022 - 2026"
      , details = [ "Focus in Computer Systems" ]
      }
    ]
