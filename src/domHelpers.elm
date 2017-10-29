module DomHelpers exposing (toDomList)

import Html exposing (Html, ul, li)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Events exposing (Msg(RemoveTodo))
import Types exposing (Content)


toDomList : List Content -> (Content -> String) -> Html Msg
toDomList entry key =
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
