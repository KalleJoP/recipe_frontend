module Data.FoodItemModel exposing (..)

import Data.Recipe.FoodItem as FoodItem
import Http
import Json.Decode as Decode


type alias Model =
    { new_food_item : FoodItem.Model
    , food_item_list : List FoodItem.Model
    , edit_food_item : FoodItem.Model
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { new_food_item = FoodItem.init
      , food_item_list = []
      , edit_food_item = FoodItem.init
      }
    , getFoodList
    )


type Msg
    = FoodItemMsg FoodItem.Msg
    | RecieveFoodItemList (Result Http.Error (List FoodItem.Model))
    | GetFoodItemList
    | SelectFoodItem String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FoodItemMsg foodItemMsg ->
            let
                ( new_food_item, cmd ) =
                    FoodItem.update foodItemMsg model.new_food_item
            in
            ( { model | new_food_item = new_food_item }, Cmd.map FoodItemMsg cmd )

        RecieveFoodItemList result ->
            case result of
                Ok item_list ->
                    ( { model | food_item_list = item_list }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        GetFoodItemList ->
            ( model, getFoodList )

        SelectFoodItem id ->
            let
                idChecker =
                    String.toInt id
            in
            case idChecker of
                Just intID ->
                    let
                        food_item =
                            getFoodItemFromList intID
                                model.food_item_list
                    in
                    case food_item of
                        Just item ->
                            ( { model | edit_food_item = item }, Cmd.none )

                        Nothing ->
                            ( model, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )


getFoodItemFromList : Int -> List FoodItem.Model -> Maybe FoodItem.Model
getFoodItemFromList id food_item_list =
    let
        selected_item =
            List.filter (\item -> item.id == id) food_item_list
    in
    List.head selected_item


getFoodList : Cmd Msg
getFoodList =
    Http.get
        { url = "/api/food_items"
        , expect = Http.expectJson RecieveFoodItemList foodItemListDecoder
        }


foodItemListDecoder : Decode.Decoder (List FoodItem.Model)
foodItemListDecoder =
    Decode.list FoodItem.foodItemDecoder
