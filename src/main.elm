module Main exposing (..)

import Html exposing (Html, input, text, button, div, ul, li)
import Html.Attributes exposing (disabled, placeholder, value, style)
import Html.Events exposing (onClick, onInput)
import Events exposing (..)
import Types exposing (Model, Content)
import DomHelpers exposing (toDomList)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }


model : Model
model =
    { content = []
    , titleInput = ""
    }


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
        , div [] [ toDomList model.content .title ]
        ]
