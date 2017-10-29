module Main exposing (..)

import Html exposing (Html, input, text, button, div, ul, li)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Content =
    { id : Int
    , title : String
    }


type alias Model =
    { content : List Content
    , titleInput : String
    }


model : Model
model =
    { content = []
    , titleInput = ""
    }


type Msg
    = AddTodo String
    | ChangeInputText String
    | RemoveTodo Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTodo title ->
            { model
                | content =
                    { id = (List.length model.content)
                    , title = title
                    }
                        :: model.content
                , titleInput = ""
            }

        RemoveTodo id ->
            { model
                | content = List.filter (\item -> item.id /= id) model.content
            }

        ChangeInputText text ->
            { model
                | titleInput = text
            }


toUlList : List Content -> (Content -> String) -> Html Msg
toUlList entry key =
    ul []
        (List.map
            (\item ->
                li
                    [ onClick <| RemoveTodo item.id
                    , style [ ( "cursor", "pointer" ), ( "padding", "3px" ) ]
                    ]
                    [ Html.text (key item) ]
            )
            entry
        )


view : Model -> Html Msg
view model =
    div [ style [ ( "padding", "20px" ) ] ]
        [ input
            [ placeholder "Enter a todo"
            , onInput ChangeInputText
            , value model.titleInput
            , style [ ( "padding", "4px" ) ]
            ]
            []
        , button
            [ onClick (AddTodo model.titleInput)
            , disabled (String.length model.titleInput == 0)
            , style
                [ ( "padding", "5px 8px" )
                , ( "margin-left", "5px" )
                , ( "cursor", "pointer" )
                ]
            ]
            [ Html.text "Add Todo" ]
        , div [] [ toUlList model.content .title ]
        ]
