module Msg exposing (..)

import Browser
import Data.FoodItemModel as FoodItemModel
import Data.Login as Login
import Data.RecipeModel as RecipeModel
import Router
import Url


type Msg
    = NoOp
    | RouteChanged Router.Route
    | ClickedLink Browser.UrlRequest
    | UrlChange Url.Url
    | LoginMsg Login.Msg
    | GetRecipeList
    | RecipeModelMsg RecipeModel.Msg
    | FoodItemModelMsg FoodItemModel.Msg
