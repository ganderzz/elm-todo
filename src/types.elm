module Types exposing (Content, Model)


type alias Content =
    { id : Int
    , title : String
    }


type alias Model =
    { content : List Content
    , titleInput : String
    }
