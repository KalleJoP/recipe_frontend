module View.EditFoodItem exposing (..)

import Data.FoodItemModel as FoodItemModel
import Data.Recipe.FoodItem as FoodItem
import Html exposing (Html, button, div, form, h1, input, option, select, text)
import Html.Attributes exposing (disabled, required, selected, type_, value)
import Html.Events exposing (onClick, onInput)
import Model
import Msg


renderFoodItemList : List FoodItem.Model -> Html Msg.Msg
renderFoodItemList food_item_list =
    select [ onInput (Msg.FoodItemModelMsg << FoodItemModel.SelectFoodItem) ]
        (List.concat
            [ [ option
                    [ disabled True, selected True ]
                    [ text "Select Item" ]
              ]
            , List.indexedMap
                (\_ food_item ->
                    option [ value (String.fromInt food_item.id) ] [ text food_item.name ]
                )
                food_item_list
            ]
        )


editFoodItem : Model.Model -> Html Msg.Msg
editFoodItem model =
    form []
        [ h1 [] [ text "Edit Food Item" ]
        , renderFoodItemList model.food_item_model.food_item_list
        , if model.food_item_model.edit_food_item /= FoodItem.init then
            div []
                [ input [ value model.food_item_model.edit_food_item.name, onInput (Msg.FoodItemModelMsg << FoodItemModel.EditFoodItemMsg << FoodItem.UpdateName), required True ] []
                , input [ value model.food_item_model.edit_food_item.quantity_type, onInput (Msg.FoodItemModelMsg << FoodItemModel.EditFoodItemMsg << FoodItem.UpdateQuantityType), required True ] []
                , button [ type_ "submit", onClick (Msg.FoodItemModelMsg (FoodItemModel.EditFoodItemMsg FoodItem.EditFootItem)) ] [ text "Save Food Item" ]
                ]

          else
            text ""
        ]
