module View.Login exposing (..)

import Data.Login as Login exposing (Msg(..))
import Html exposing (Html, button, div, h1, img, input, label, p, text)
import Html.Attributes exposing (class, for, name, placeholder, src, type_)
import Html.Events exposing (onClick, onInput)
import Model
import Msg
import Router


login : Model.Model -> List (Html Msg.Msg)
login _ =
    [ div [ class "w-full" ]
        [ div [ class "max-w-xs m-auto my-32" ]
            [ img [ class "block mr-auto ml-auto w-32", src "/assets/wave.svg" ] []
            , h1 [ class "" ] [ text "Recipes" ]
            , div [ class "bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4" ]
                [ div [ class "mb-4" ]
                    [ label [ class "block text-gray-700 text-sm font-bold mb-2 float-left", for "username" ]
                        [ text "Benutzername" ]
                    , input [ class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline", name "username", placeholder "Mitarbeiter", type_ "text", onInput (Msg.LoginMsg << Login.UpdateUsername) ]
                        []
                    , text "                    "
                    ]
                , div [ class "mb-6" ]
                    [ label [ class "block text-gray-700 text-sm font-bold mb-2 float-left", for "password" ]
                        [ text "Passwort                    " ]
                    , input [ class "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline", name "password", placeholder "******************", type_ "password", onInput (Msg.LoginMsg << Login.UpdatePassword) ]
                        []
                    , p [ class "text-red-500 text-xs italic" ]
                        []
                    ]
                , div [ class "flex items-center justify-between" ]
                    [ button [ onClick (Msg.RouteChanged Router.Dashboard), class "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline", type_ "button" ]
                        [ text "Login" ]
                    ]
                ]
            , p [ class "text-center text-gray-500 text-xs" ]
                [ text "2020 Recipes." ]
            ]
        ]
    ]
