module View.Dashboard exposing (..)

import Html exposing (Html, div, h1, h2, text)
import Html.Attributes exposing (class)
import Model
import Msg


dashboard : Model.Model -> List (Html Msg.Msg)
dashboard model =
    [ div [ class "w-full h-full" ]
        [ h1 []
            [ text "Dashboard" ]
        , text
            model.recipe_list.errorMsg
        , h2 []
            [ text "Einkaufliste anzeigen lassen!"
            ]
        ]
    ]
