module Data.RecipeModel exposing (..)

import Data.Recipe.Recipe as Recipe
import Data.Recipe.RecipeItem as RecipeItem
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (optional, required)


type DialogStatus
    = Edit
    | New
    | Close


type alias Model =
    { errorMsg : String
    , recipe_list : List Recipe.Model
    , edit_recipe : Recipe.Model
    , dialog_status : DialogStatus
    , new_recipe : Recipe.Model
    , new_recipe_item : RecipeItem.Model
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { errorMsg = "", recipe_list = [], edit_recipe = Recipe.init, dialog_status = Close, new_recipe = Recipe.init, new_recipe_item = RecipeItem.init }
    , getRecipeList
    )


type Msg
    = RecieveRecipeList (Result Http.Error (List Recipe.Model))
    | GetRecipeList
    | SetEditRecipe Recipe.Model
    | CloseDialog
    | SetNewRecipe
    | RecipeItemMsg RecipeItem.Msg
    | RecipeMsg Recipe.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RecipeMsg recipeMsg ->
            let
                ( recipe, cmd ) =
                    Recipe.update recipeMsg model.new_recipe
            in
            ( { model | new_recipe = recipe, new_recipe_item = RecipeItem.init }, Cmd.map RecipeMsg cmd )

        RecipeItemMsg recipeItemMsg ->
            let
                ( recipe_item, cmd ) =
                    RecipeItem.update recipeItemMsg model.new_recipe_item
            in
            ( { model | new_recipe_item = recipe_item }, Cmd.map RecipeItemMsg cmd )

        CloseDialog ->
            ( { model | edit_recipe = Recipe.init, dialog_status = Close }, Cmd.none )

        SetEditRecipe recipe ->
            ( { model | edit_recipe = recipe, dialog_status = Edit }, Cmd.none )

        SetNewRecipe ->
            ( { model | dialog_status = New }, Cmd.none )

        RecieveRecipeList result ->
            case result of
                Ok recipe ->
                    ( { model | recipe_list = recipe }, Cmd.none )

                Err err ->
                    case err of
                        Http.BadBody errMsg ->
                            ( { model | errorMsg = "BadBody: " ++ errMsg }, Cmd.none )

                        Http.BadUrl errMsg ->
                            ( { model | errorMsg = errMsg }, Cmd.none )

                        Http.BadStatus errMsg ->
                            ( { model | errorMsg = String.fromInt errMsg }, Cmd.none )

                        Http.Timeout ->
                            ( model, Cmd.none )

                        Http.NetworkError ->
                            ( model, Cmd.none )

        GetRecipeList ->
            ( model, getRecipeList )



-- getRecipeList : Cmd Msg
-- getRecipeList =
--     Http.get
--         { url = "/api/recipes"
--         , expect = Http.expectJson RecieveRecipeList recipeDecoder
--         }


getRecipeList : Cmd Msg
getRecipeList =
    Http.get
        { url = "/api/recipes"
        , expect = Http.expectJson RecieveRecipeList Recipe.recipeListDecoder
        }
