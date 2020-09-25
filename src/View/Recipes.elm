module View.Recipes exposing (..)

import Data.Recipe.FoodItem as FoodItem
import Data.Recipe.Recipe as Recipe
import Data.Recipe.RecipeItem as RecipeItem
import Data.RecipeModel as RecipeModel
import FeatherIcons
import Html exposing (Html, a, button, div, footer, form, h1, h2, h3, img, input, label, li, option, p, select, text, textarea, ul)
import Html.Attributes exposing (alt, class, disabled, for, height, href, id, placeholder, required, selected, src, value, width)
import Html.Events exposing (onClick, onInput)
import Model
import Msg exposing (Msg(..))


recipes : Model.Model -> Html Msg.Msg
recipes model =
    div [ class "flex flex-wrap justify-center" ]
        [ div [ class "flex-none w-full font-bold text-white text-center  text-xl mb-2" ]
            [ text "Rezepte" ]
        , div [ class "container p-4" ] [ recipeListRenderer model ]
        ]


recipeListRenderer : Model.Model -> Html Msg.Msg
recipeListRenderer model =
    div [ class "flex flex-wrap pb-16 justify-evenly" ]
        (case model.recipe_model.dialog_status of
            RecipeModel.Close ->
                List.concat
                    [ List.indexedMap
                        (\_ recipe ->
                            button [ onClick (Msg.RecipeModelMsg (RecipeModel.SetEditRecipe recipe)) ]
                                [ div [ class "card-shadow cursor-pointer bg-gray-800 text-white flex-none lg:w-64 md:w-64 w-full p-2 lg:p-0 md:p-0 sm:w-64 sm:p-0 mb-4 rounded overflow-hidden shadow-lg flex flex-wrap" ]
                                    [ div [ class "flex-none w-full h-64" ] [ img [ src recipe.picture, class "w-full object-scale-down h-full", alt "image" ] [] ]
                                    , div [ class "px-6 py-4 flex-none w-full" ]
                                        [ div [ class "font-bold text-xl mb-2" ] [ text recipe.name ]
                                        , p [ class "text-gray-700 text-base" ] [ text recipe.description ]
                                        ]
                                    ]
                                ]
                        )
                        model.recipe_model.recipe_list
                    , [ button [ onClick (Msg.RecipeModelMsg RecipeModel.SetNewRecipe) ]
                            [ div
                                [ class "border-green-500 border-solid border-2 card-shadow cursor-pointer bg-gray-800 text-white lg:w-64 md:w-64 w-full mb-4 sm:w-64 sm:p-0 flex-none w-1/3 rounded overflow-hidden shadow-lg flex flex-wrap justify-between" ]
                                [ div [ class "flex-none w-full h-64" ] [ img [ src "https://freesvg.org/img/primary-tab-new.png", class "w-full object-scale-down h-full", alt "image" ] [] ]
                                , div [ class "px-6 py-4 flex-none w-full" ]
                                    [ div [ class "font-bold text-xl mb-2" ] [ text "Neues Recept" ]
                                    , p [ class "text-gray-700 text-base" ] [ text "Erstellen Sie ein neues Rezept!" ]
                                    ]
                                ]
                            ]
                      ]
                    ]

            RecipeModel.Edit ->
                [ editRecipe model.recipe_model.edit_recipe
                ]

            RecipeModel.New ->
                [ newRecipe model
                ]
        )


newRecipe : Model.Model -> Html Msg.Msg
newRecipe model =
    div [ class "w-full max-w-lg" ]
        [ div [ class "flex flex-wrap -mx-3 mb-6 text-white" ]
            [ h1
                [ class "mb-6 w-full text-center" ]
                [ text "Neues Rezept erstellen" ]
            , div [ class "w-full  px-3 mb-6 md:mb-0" ]
                [ label [ class "block uppercase tracking-wide text-white text-xs font-bold mb-2", for "grid-name-new" ] [ text "Name" ]
                , input [ class "appearance-none block w-full bg-gray-200 text-gray-700 border border-red-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white", id "grid-name-new", placeholder "Name", required True ] []
                ]
            , div [ class "w-full  px-3 mb-6 md:mb-0" ]
                [ label [ class "block uppercase tracking-wide text-white text-xs font-bold mb-2", for "grid-picture-new" ] [ text "Bild" ]
                , input [ class "appearance-none block w-full bg-gray-200 text-gray-700 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white", id "grid-picture-new", placeholder "Url" ] []
                ]
            , div [ class "w-full  px-3 mb-6 md:mb-0" ]
                [ label [ class "block uppercase tracking-wide text-white text-xs font-bold mb-2", for "grid-describ-new" ] [ text "Beschreibung" ]
                , textarea [ class "appearance-none block w-full bg-gray-200 text-gray-700 border border-red-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white resize-none h-32", id "grid-describ-new", placeholder "Beschreibung", required True ] []
                ]
            , div [ class "w-full " ]
                [ p [ class "text-lg text-center" ] [ text "Zutaten" ]
                , div [ class " w-full" ]
                    (List.concat
                        [ [ div [ class "w-full flex flex-wrap mb-6 h-20" ]
                                [ div [ class "w-1/3 px-3 mb-6 md:mb-0" ]
                                    [ label [ class " block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2", for "grid-quantity-new" ] [ text "Menge pro Person" ]
                                    , input [ value (String.fromInt model.recipe_model.new_recipe_item.quantity), onInput (Msg.RecipeModelMsg << RecipeModel.RecipeItemMsg << RecipeItem.EditQuantity), class "h-10 appearance-none block w-full bg-gray-200 text-gray-700 border border-red-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white", id "grid-quantity-new", placeholder "Menge" ] []
                                    ]
                                , div [ class "w-1/2 px-3 mb-6 md:mb-0" ]
                                    [ label [ class "block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2", for "grid-product-new" ] [ text "Produkt" ]
                                    , renderNewFoodItemList model.food_item_model.food_item_list model.recipe_model.new_recipe_item.food_item
                                    ]
                                , button [ class "h-full mt-1", onClick (Msg.RecipeModelMsg (RecipeModel.RecipeMsg (Recipe.AddRecipeItem model.recipe_model.new_recipe_item))) ]
                                    [ FeatherIcons.plus
                                        |> FeatherIcons.toHtml []
                                    ]
                                ]
                          ]
                        , List.indexedMap
                            (\_ recipeItem ->
                                div [ class "w-full flex flex-wrap mb-6 h-20" ]
                                    [ div [ class "w-1/3 px-3 mb-6 md:mb-0" ]
                                        [ label [ class " block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2", for "grid-quantity-new" ] [ text "Menge pro Person" ]
                                        , input [ value (String.fromInt recipeItem.quantity), class "h-10 appearance-none block w-full bg-gray-200 text-gray-700 border border-red-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white", id "grid-quantity-new", placeholder "Menge" ] []
                                        ]
                                    , div [ class "w-1/2 px-3 mb-6 md:mb-0" ]
                                        [ label [ class "block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2", for "grid-product-new" ] [ text "Produkt" ]
                                        , renderFoodItemList model.food_item_model.food_item_list recipeItem.food_item
                                        ]

                                    -- , button [ class "h-full mt-1", onClick (Msg.RecipeModelMsg (RecipeModel.RecipeMsg (Recipe.AddRecipeItem model.recipe_model.new_recipe_item))) ]
                                    --     [ FeatherIcons.plus
                                    --         |> FeatherIcons.toHtml []
                                    --     ]
                                    ]
                            )
                            model.recipe_model.new_recipe.recipe_items
                        ]
                    )

                -- , button [ onClick (Msg.RecipeMsg Recipe.CloseDialog) ] [ text "Zurück" ]
                ]
            ]
        ]


editRecipe : Recipe.Model -> Html Msg.Msg
editRecipe recipe =
    div [ class "text-white" ]
        [ h1 [] [ text "Rezept bearbeiten" ]
        , p [] [ text recipe.name ]
        , button [ onClick (Msg.RecipeModelMsg RecipeModel.CloseDialog) ] [ text "Zurück" ]
        ]


renderNewFoodItemList : List FoodItem.Model -> FoodItem.Model -> Html Msg.Msg
renderNewFoodItemList food_item_list item =
    select [ onInput (Msg.RecipeModelMsg << RecipeModel.RecipeItemMsg << RecipeItem.EditFoodItem food_item_list), class "h-10 block appearance-none w-full text-black bg-white border border-gray-400 hover:border-gray-500 px-4 py-2 pr-8 rounded shadow leading-tight focus:outline-none focus:shadow-outline", id "grid-product-new" ]
        (List.concat
            [ [ option
                    [ disabled True, selected (item == FoodItem.init), value "" ]
                    [ text "Select Item" ]
              ]
            , List.indexedMap
                (\index food_item ->
                    option [ value (String.fromInt index) ] [ text (food_item.name ++ " in " ++ food_item.quantity_type) ]
                )
                food_item_list
            ]
        )


renderFoodItemList : List FoodItem.Model -> FoodItem.Model -> Html Msg.Msg
renderFoodItemList food_item_list selectedItem =
    select [ onInput (Msg.RecipeModelMsg << RecipeModel.RecipeItemMsg << RecipeItem.EditFoodItem food_item_list), class "h-10 block appearance-none w-full text-black bg-white border border-gray-400 hover:border-gray-500 px-4 py-2 pr-8 rounded shadow leading-tight focus:outline-none focus:shadow-outline", id "grid-product-new" ]
        (List.indexedMap
            (\index food_item ->
                let
                    select =
                        food_item == selectedItem
                in
                option [ value (String.fromInt index), selected select ] [ text (food_item.name ++ " in " ++ food_item.quantity_type) ]
            )
            food_item_list
        )
