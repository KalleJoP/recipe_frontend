module View.NavBar exposing (..)

import FeatherIcons
import Html exposing (Html, a, div, section, span, text)
import Html.Attributes exposing (class, href)
import Model
import Msg


navBar : Model.Model -> Html Msg.Msg
navBar model =
    let
        ( colorHome, colorRecipe, colorEdit ) =
            case model.nav_status of
                Model.HomeActive ->
                    ( "text-red-500", "", "" )

                Model.EditActive ->
                    ( "", "", "text-red-500" )

                Model.RecipeActive ->
                    ( "", "text-red-500", "" )
    in
    section [ class "block fixed inset-x-0 bottom-0 z-10 bg-gray-800 shadow" ]
        [ div [ class "flex justify-between text-white" ]
            [ a [ href "/", class ("w-full justify-center inline-block text-center pt-2 pb-1 " ++ colorHome) ]
                [ FeatherIcons.home
                    |> FeatherIcons.withClass "inline-block mb-1"
                    |> FeatherIcons.toHtml []
                , span [ class "tab tab-home block text-xs" ] [ text "Home" ]
                ]
            , a [ href "/recipes", class ("w-full justify-center inline-block text-center pt-2 pb-1 " ++ colorRecipe) ]
                [ FeatherIcons.list
                    |> FeatherIcons.withClass "inline-block mb-1"
                    |> FeatherIcons.toHtml []
                , span [ class "tab tab-home block text-xs" ] [ text "Rezepte" ]
                ]
            , a [ href "/edit", class ("w-full justify-center inline-block text-center pt-2 pb-1 " ++ colorEdit) ]
                [ FeatherIcons.edit
                    |> FeatherIcons.withClass "inline-block mb-1"
                    |> FeatherIcons.toHtml []
                , span [ class "tab tab-home block text-xs" ] [ text "Editor" ]
                ]
            ]
        ]
