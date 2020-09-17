module Model exposing (..)

import Browser.Navigation as Nav
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
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg.Msg )
init _ url key =
    let
        ( recipe_list, cmd ) =
            Recipe.init ()
    in
    ( { activeRoute = Router.nextRoute url
      , key = key
      , login = Login.init
      , recipe_list = recipe_list
      }
    , Cmd.map Msg.RecipeMsg cmd
    )
