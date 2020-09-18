module Main exposing (..)

import Bootstrap.Grid as Grid
import Bootstrap.Navbar as Navbar
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
import View.EditFoodItem
import View.Login
import View.NavBar


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
        [ div []
            [ View.NavBar.navBar model
            , mainContent model
            ]
        ]
    }


mainContent : Model.Model -> Html Msg.Msg
mainContent model =
    Grid.containerFluid [ class "container-margin" ] <|
        case model.activeRoute of
            Router.Dashboard ->
                View.Dashboard.dashboard model

            Router.Login ->
                View.Login.login model

            Router.CreateFoodItem ->
                View.CreateFoodItem.createFoodItem model

            Router.EditFoodItem ->
                View.EditFoodItem.editFoodItem model


subscriptions : Model.Model -> Sub Msg.Msg
subscriptions model =
    Navbar.subscriptions model.navState Msg.NavMsg



---- PROGRAM ----


main : Program () Model.Model Msg.Msg
main =
    Browser.application
        { view = view
        , init = Model.init
        , update = Update.update
        , subscriptions = subscriptions
        , onUrlChange = onUrlChange
        , onUrlRequest = onUrlRequest
        }
