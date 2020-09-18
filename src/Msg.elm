module Msg exposing (..)

import Bootstrap.Navbar as Navbar
import Browser
import Data.FoodItemModel as FoodItemModel
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
    | NavMsg Navbar.State
    | FoodItemModelMsg FoodItemModel.Msg
