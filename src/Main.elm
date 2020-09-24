module Main exposing (..)

import Browser
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Model
import Msg
import Router
import Update
import Url
import View.CreateFoodItem
import View.Dashboard
import View.Edit
import View.EditFoodItem
import View.Login
import View.NavBar
import View.Recipes


onUrlRequest : Browser.UrlRequest -> Msg.Msg
onUrlRequest req =
    Msg.ClickedLink req


onUrlChange : Url.Url -> Msg.Msg
onUrlChange url =
    Msg.UrlChange url



---- VIEW ----


view : Model.Model -> Browser.Document Msg.Msg
view model =
    { title = "Recipes"
    , body =
        [ div [ class "bg-gray-900 h-full min-h-screen w-full" ]
            [ mainContent model
            , View.NavBar.navBar model
            ]
        ]
    }


mainContent : Model.Model -> Html Msg.Msg
mainContent model =
    div [ class " h-full w-full" ]
        [ case model.activeRoute of
            Router.Dashboard ->
                View.Dashboard.dashboard model

            Router.Login ->
                View.Login.login model

            Router.CreateFoodItem ->
                View.CreateFoodItem.createFoodItem model

            Router.EditFoodItem ->
                View.EditFoodItem.editFoodItem model

            Router.EditForm ->
                View.Edit.edit model

            Router.RecipeForm ->
                View.Recipes.recipes model
        ]



---- PROGRAM ----


main : Program () Model.Model Msg.Msg
main =
    Browser.application
        { view = view
        , init = Model.init
        , update = Update.update
        , subscriptions = always Sub.none
        , onUrlChange = onUrlChange
        , onUrlRequest = onUrlRequest
        }
