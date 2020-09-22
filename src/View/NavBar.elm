module View.NavBar exposing (..)

import Html exposing (Html, a, div, text)
import Html.Attributes exposing (href)
import Model
import Msg


navBar : Model.Model -> Html Msg.Msg
navBar _ =
    div []
        [ a [ href "/create-food-item" ] [ text "Create Food Item" ]
        , a [ href "/edit-food-item" ] [ text "Edit Food Item" ]
        ]
