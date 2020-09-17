module Main exposing (..)

import Browser
import Model
import Msg
import Router
import Update
import Url
import View.Dashboard
import View.Login


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
        [ case model.activeRoute of
            Router.Dashboard ->
                View.Dashboard.dashboard model

            Router.Login ->
                View.Login.login model
        ]
    }



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
