module Model exposing (..)

import Browser.Navigation as Nav
import Data.FoodItemModel as FoodItemModel
import Data.Login as Login
import Data.Recipe as Recipe
import Msg exposing (Msg(..))
import Router exposing (Route(..))
import Url


type alias Model =
    { activeRoute : Router.Route
    , key : Nav.Key
    , login : Login.Model
    , recipe_list : Recipe.Model
    , food_item_model : FoodItemModel.Model
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg.Msg )
init _ url key =
    let
        ( recipe_list, cmd ) =
            Recipe.init ()

        ( food_item, food_item_cmd ) =
            FoodItemModel.init ()
    in
    ( { activeRoute = Router.nextRoute url
      , key = key
      , login = Login.init
      , recipe_list = recipe_list
      , food_item_model = food_item
      }
    , Cmd.batch [ Cmd.map Msg.RecipeMsg cmd, Cmd.map Msg.FoodItemModelMsg food_item_cmd ]
    )
