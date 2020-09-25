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


type Msg
    = EditQuantity String
    | EditFoodItem (List FoodItem.Model) String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EditQuantity quantityStr ->
            let
                convertResult =
                    String.toInt quantityStr
            in
            case convertResult of
                Just quantity ->
                    ( { model | quantity = quantity }, Cmd.none )

                Nothing ->
                    ( { model | quantity = 0 }, Cmd.none )

        EditFoodItem food_item_list indexStr ->
            let
                convertResult =
                    String.toInt indexStr
            in
            case convertResult of
                Just index ->
                    case List.head (List.drop index food_item_list) of
                        Just food_item ->
                            ( { model | food_item = food_item }, Cmd.none )

                        Nothing ->
                            ( { model | food_item = FoodItem.init }, Cmd.none )

                Nothing ->
                    ( { model | food_item = FoodItem.init }, Cmd.none )


recipeItemDecoder : Decoder Model
recipeItemDecoder =
    Decode.succeed Model
        |> required "id" Decode.int
        |> required "quantity" Decode.int
        |> required "food_item" FoodItem.foodItemDecoder


recipeItemListDecoder : Decoder (List Model)
recipeItemListDecoder =
    Decode.list recipeItemDecoder
