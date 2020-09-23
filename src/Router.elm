module Router exposing (..)

import Url


type Route
    = Login
    | Dashboard
    | CreateFoodItem
    | EditFoodItem
    | EditForm
    | RecipeForm


nextRoute : Url.Url -> Route
nextRoute url =
    case url.path of
        "/create-food-item" ->
            CreateFoodItem

        "/edit-food-item" ->
            EditFoodItem

        "/edit" ->
            EditForm

        "/recipes" ->
            RecipeForm

        _ ->
            Dashboard
