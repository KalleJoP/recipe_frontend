module View.CreateFoodItem exposing (..)

import Bootstrap.Button as Button
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Form.InputGroup as InputGroup
import Data.FoodItemModel as FoodItemModel
import Data.Recipe.FoodItem as FoodItem
import Html exposing (Html, h1, text)
import Html.Attributes exposing (required)
import Html.Events exposing (onInput, onSubmit)
import Model
import Msg


createFoodItem : Model.Model -> List (Html Msg.Msg)
createFoodItem _ =
    [ Form.form [ onSubmit (Msg.FoodItemModelMsg (FoodItemModel.FoodItemMsg FoodItem.SaveFoodItem)) ]
        [ h1 [] [ text "Create Food Item" ]
        , InputGroup.config
            (InputGroup.text [ Input.onInput (Msg.FoodItemModelMsg << FoodItemModel.FoodItemMsg << FoodItem.UpdateName), Input.attrs [ required True ] ])
            |> InputGroup.large
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text "Name" ]
                ]
            |> InputGroup.view
        , InputGroup.config
            (InputGroup.text [ Input.onInput (Msg.FoodItemModelMsg << FoodItemModel.FoodItemMsg << FoodItem.UpdateQuantityType), Input.attrs [ required True ] ])
            |> InputGroup.large
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text "Mengeneangabe" ]
                ]
            |> InputGroup.view
        , Button.submitButton [ Button.success ] [ text "Save Food Item" ]
        ]
    ]
