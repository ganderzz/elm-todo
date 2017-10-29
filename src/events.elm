module Events exposing (Msg(..))


type Msg
    = AddTodo String
    | ChangeInputText String
    | RemoveTodo Int
