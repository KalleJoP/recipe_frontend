module View.EditFoodItem exposing (..)

import Bootstrap.Button as Button
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Form.InputGroup as InputGroup
import Data.FoodItemModel as FoodItemModel
import Data.Recipe.FoodItem as FoodItem
import Html exposing (Html, div, h1, option, select, text)
import Html.Attributes exposing (required, value)
import Html.Events exposing (onInput)
import Model
import Msg


renderFoodItemList : List FoodItem.Model -> Html Msg.Msg
renderFoodItemList food_item_list =
    select [ onInput (Msg.FoodItemModelMsg << FoodItemModel.SelectFoodItem) ]
        (List.indexedMap
            (\_ food_item ->
                option [ value (String.fromInt food_item.id) ] [ text food_item.name ]
            )
            food_item_list
        )


editFoodItem : Model.Model -> List (Html Msg.Msg)
editFoodItem model =
    [ Form.form []
        [ h1 [] [ text "Edit Food Item" ]
        , renderFoodItemList model.food_item_model.food_item_list
        , if model.food_item_model.edit_food_item /= FoodItem.init then
            div []
                [ InputGroup.config
                    (InputGroup.text [ Input.value model.food_item_model.edit_food_item.name, Input.onInput (Msg.FoodItemModelMsg << FoodItemModel.FoodItemMsg << FoodItem.UpdateName), Input.attrs [ required True ] ])
                    |> InputGroup.large
                    |> InputGroup.predecessors
                        [ InputGroup.span [] [ text "Name" ]
                        ]
                    |> InputGroup.view
                , InputGroup.config
                    (InputGroup.text [ Input.value model.food_item_model.edit_food_item.quantity_type, Input.onInput (Msg.FoodItemModelMsg << FoodItemModel.FoodItemMsg << FoodItem.UpdateQuantityType), Input.attrs [ required True ] ])
                    |> InputGroup.large
                    |> InputGroup.predecessors
                        [ InputGroup.span [] [ text "Mengeneangabe" ]
                        ]
                    |> InputGroup.view
                , Button.submitButton [ Button.success ] [ text "Save Food Item" ]
                ]

          else
            text ""
        ]
    ]
