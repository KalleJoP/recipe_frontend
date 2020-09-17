module Msg exposing (..)

import Browser
import Data.Login as Login
import Data.Recipe as Recipe
import Router
import Url


type Msg
    = NoOp
    | RouteChanged Router.Route
    | ClickedLink Browser.UrlRequest
    | UrlChange Url.Url
    | LoginMsg Login.Msg
    | GetRecipeList
    | RecipeMsg Recipe.Msg
