module Router exposing (..)

import Url


type Route
    = Login
    | Dashboard
    | CreateFoodItem
    | EditFoodItem


nextRoute : Url.Url -> Route
nextRoute url =
    case url.path of
        "/create-food-item" ->
            CreateFoodItem

        "/edit-food-item" ->
            EditFoodItem

        _ ->
            Dashboard
