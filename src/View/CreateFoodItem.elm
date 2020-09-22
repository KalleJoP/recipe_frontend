module View.CreateFoodItem exposing (..)

import Data.FoodItemModel as FoodItemModel
import Data.Recipe.FoodItem as FoodItem
import Html exposing (Html, button, form, h1, input, text)
import Html.Attributes exposing (required, type_)
import Html.Events exposing (onInput, onSubmit)
import Model
import Msg


createFoodItem : Model.Model -> List (Html Msg.Msg)
createFoodItem _ =
    [ form [ onSubmit (Msg.FoodItemModelMsg (FoodItemModel.FoodItemMsg FoodItem.SaveFoodItem)) ]
        [ h1 [] [ text "Create Food Item" ]
        , input [ onInput (Msg.FoodItemModelMsg << FoodItemModel.FoodItemMsg << FoodItem.UpdateName), required True ] []
        , input [ onInput (Msg.FoodItemModelMsg << FoodItemModel.FoodItemMsg << FoodItem.UpdateQuantityType), required True ] []
        , button [ type_ "submit" ] [ text "Save Food Item" ]
        ]
    ]
