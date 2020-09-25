module Data.Recipe.Recipe exposing (..)

import Data.Recipe.RecipeItem as RecipeItem
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (optional, required)


type alias Model =
    { id : Int
    , name : String
    , description : String
    , picture : String
    , recipe_items : List RecipeItem.Model
    }


init : Model
init =
    { id = 0, name = "", description = "", picture = "", recipe_items = [] }


type Msg
    = AddRecipeItem RecipeItem.Model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddRecipeItem recipe_item ->
            ( { model | recipe_items = List.append model.recipe_items [ recipe_item ] }, Cmd.none )


recipeDecoder : Decoder Model
recipeDecoder =
    Decode.succeed Model
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "description" Decode.string
        |> optional "picture" Decode.string ""
        |> optional "recipe_items" RecipeItem.recipeItemListDecoder []


recipeListDecoder : Decode.Decoder (List Model)
recipeListDecoder =
    Decode.list recipeDecoder
