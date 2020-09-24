module View.Recipes exposing (..)

import Data.Recipe as Recipe
import Data.Recipe.RecipeItem as RecipeItem
import Html exposing (Html, button, div, footer, h1, img, li, p, text, ul)
import Html.Attributes exposing (alt, class, height, src, width)
import Model
import Msg


recipes : Model.Model -> Html Msg.Msg
recipes model =
    div [ class "flex flex-wrap justify-center" ]
        [ div [ class "flex-none w-full font-bold text-white  text-xl mb-2" ]
            [ text "Rezepte" ]
        , div [ class "container p-4" ] [ recipeListRenderer model.recipe_list ]
        ]


recipeItemListRenderer : List RecipeItem.Model -> Html Msg.Msg
recipeItemListRenderer recipeItemModelList =
    ul []
        (List.indexedMap
            (\_ recipeItem ->
                li []
                    [ text (recipeItem.food_item.name ++ " " ++ String.fromInt recipeItem.quantity ++ " " ++ recipeItem.food_item.quantity_type)
                    ]
            )
            recipeItemModelList
        )


recipeListRenderer : Recipe.Model -> Html Msg.Msg
recipeListRenderer recipeModel =
    div [ class "flex flex-wrap pb-16 justify-evenly" ]
        (List.concat
            [ List.indexedMap
                (\_ recipe ->
                    div [ class "card-shadow cursor-pointer bg-gray-800 text-white flex-none lg:w-64 md:w-64 w-full p-2 lg:p-0 md:p-0 sm:w-64 sm:p-0 mb-4 rounded overflow-hidden shadow-lg flex flex-wrap" ]
                        [ div [ class "flex-none w-full h-64" ] [ img [ src recipe.picture, class "w-full object-scale-down h-full", alt "image" ] [] ]
                        , div [ class "px-6 py-4 flex-none w-full" ]
                            [ div [ class "font-bold text-xl mb-2" ] [ text recipe.name ]
                            , p [ class "text-gray-700 text-base" ] [ text recipe.description ]
                            ]
                        ]
                )
                recipeModel.recipe_list
            , [ div
                    [ class "border-green-500 border-solid border-2 card-shadow cursor-pointer bg-gray-800 text-white lg:w-64 md:w-64 w-full mb-4 sm:w-64 sm:p-0 flex-none w-1/3 rounded overflow-hidden shadow-lg flex flex-wrap justify-between" ]
                    [ div [ class "flex-none w-full h-64" ] [ img [ src "https://freesvg.org/img/primary-tab-new.png", class "w-full object-scale-down h-full", alt "image" ] [] ]
                    , div [ class "px-6 py-4 flex-none w-full" ]
                        [ div [ class "font-bold text-xl mb-2" ] [ text "Neues Recept" ]
                        , p [ class "text-gray-700 text-base" ] [ text "Erstellen Sie ein neues Rezept!" ]
                        ]
                    ]
              ]
            ]
        )
