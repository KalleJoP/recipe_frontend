module View.Edit exposing (..)

import Html exposing (Html, a, div, h1, text)
import Html.Attributes exposing (class, href)
import Model
import Msg


edit : Model.Model -> List (Html Msg.Msg)
edit _ =
    [ div []
        [ h1 [] [ text "Füge neue Lebensmittelprodukte hinzu oder bearbeite vorhandene!" ]
        , a [ href "/create-food-item", class "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" ] [ text "Neues Produkt anlegen" ]
        , a [ href "/edit-food-item", class "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" ] [ text "Vorhandenes bearbeiten" ]
        ]
    ]
