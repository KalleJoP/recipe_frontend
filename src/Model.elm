module Model exposing (..)

import Browser.Navigation as Nav
import Data.FoodItemModel as FoodItemModel
import Data.Login as Login
import Data.RecipeModel as RecipeModel
import Msg exposing (Msg(..))
import Router exposing (Route(..))
import Url


type NavStatus
    = HomeActive
    | RecipeActive
    | EditActive


type alias Model =
    { activeRoute : Router.Route
    , key : Nav.Key
    , login : Login.Model
    , recipe_model : RecipeModel.Model
    , food_item_model : FoodItemModel.Model
    , nav_status : NavStatus
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg.Msg )
init _ url key =
    let
        ( recipe_model, cmd ) =
            RecipeModel.init ()

        ( food_item, food_item_cmd ) =
            FoodItemModel.init ()
    in
    ( { activeRoute = Router.nextRoute url
      , key = key
      , login = Login.init
      , recipe_model = recipe_model
      , food_item_model = food_item
      , nav_status = getNavstatus url
      }
    , Cmd.batch [ Cmd.map Msg.RecipeModelMsg cmd, Cmd.map Msg.FoodItemModelMsg food_item_cmd ]
    )


getNavstatus : Url.Url -> NavStatus
getNavstatus url =
    case Router.nextRoute url of
        Router.CreateFoodItem ->
            EditActive

        Router.EditFoodItem ->
            EditActive

        Router.EditForm ->
            EditActive

        Router.RecipeForm ->
            RecipeActive

        Router.Dashboard ->
            HomeActive

        Router.Login ->
            HomeActive
