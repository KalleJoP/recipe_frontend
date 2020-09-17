module Data.Recipe.RecipeItem exposing (..)

import Data.Recipe.FoodItem as FoodItem
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)


type alias Model =
    { id : Int
    , quantity : Int
    , food_item : FoodItem.Model
    }


init : Model
init =
    { id = 0
    , quantity = 0
    , food_item = FoodItem.init
    }


recipeItemDecoder : Decoder Model
recipeItemDecoder =
    Decode.succeed Model
        |> required "id" Decode.int
        |> required "quantity" Decode.int
        |> required "food_item" FoodItem.foodItemDecoder


recipeItemListDecoder : Decoder (List Model)
recipeItemListDecoder =
    Decode.list recipeItemDecoder
