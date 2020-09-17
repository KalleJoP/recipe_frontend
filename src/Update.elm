module Update exposing (..)

import Browser
import Browser.Navigation as Nav
import Data.Login as Login
import Data.Recipe as Recipe
import Model
import Msg exposing (Msg(..))
import Router
import Url


update : Msg.Msg -> Model.Model -> ( Model.Model, Cmd Msg.Msg )
update msg model =
    case msg of
        RouteChanged route ->
            ( { model | activeRoute = route }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )

        ClickedLink req ->
            case req of
                Browser.Internal url ->
                    ( { model | activeRoute = Router.nextRoute url }, Nav.pushUrl model.key (Url.toString url) )

                Browser.External url ->
                    ( model, Nav.load url )

        UrlChange url ->
            ( { model | activeRoute = Router.nextRoute url }, Cmd.none )

        LoginMsg loginMsg ->
            let
                ( login, cmd ) =
                    Login.update loginMsg model.login
            in
            ( { model | login = login }, cmd )

        GetRecipeList ->
            ( model, Cmd.none )

        RecipeMsg recipeMsg ->
            let
                ( recipe_list, _ ) =
                    Recipe.update recipeMsg model.recipe_list
            in
            ( { model | recipe_list = recipe_list }, Cmd.none )
