module View.Dashboard exposing (..)

import Data.Recipe as Recipe
import Data.Recipe.RecipeItem as RecipeItem
import Html exposing (Html, button, div, footer, h1, img, li, p, text, ul)
import Html.Attributes exposing (alt, class, height, src, width)
import Model
import Msg


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



-- ul [ class "list-unstyled mt-3 mb-4" ]
--     (List.indexedMap
--         (\_ recipeItem ->
--             li []
--                 [ text (recipeItem.food_item.name ++ " " ++ String.fromInt recipeItem.quantity ++ " " ++ recipeItem.food_item.quantity_type)
--                 ]
--         )
--         recipeItemModelList
--     )
-- div [ class "card mb-4 box-shadow" ]
--                             [ div [ class "card-header" ]
--                                 [ h1 [] [ text recipe.name ]
--                                 ]
--                             , div [ class "card-body" ]
--                                 [ img [ src recipe.picture, class "img-thumbnail", alt "image", width 100, height 10 ] []
--                                 , recipeItemListRenderer recipe.recipe_items
--                                 ]
--                             , div [ class "card-footer" ]
--                                 [ button [ class "btn btn-success" ] [ text "Add to list" ]
--                                 ]
--                             ]


recipeListRenderer : Recipe.Model -> Html Msg.Msg
recipeListRenderer recipeModel =
    div [ class "card-deck text-center" ]
        (List.concat
            [ List.indexedMap
                (\_ recipe ->
                    if List.length recipe.recipe_items /= 0 then
                        div [ class "col-sm-6 col-md-6 col-lg-4 mb-5" ]
                            [ div []
                                [ h1 [] [ text recipe.name ]
                                , footer [] [ button [] [ text "Add to list" ] ]
                                , div []
                                    [ img [ src recipe.picture, class "img-thumbnail", alt "image", width 100, height 10 ] []
                                    , recipeItemListRenderer recipe.recipe_items
                                    ]
                                ]
                            ]

                    else
                        div [ class "col-sm-6 col-md-6 col-lg-4 mb-5" ]
                            [ div []
                                [ h1 [] [ text recipe.name ]
                                , div []
                                    [ img [ src recipe.picture, class "img-thumbnail", alt "image", width 100, height 10 ] []
                                    , p [] [ text "Kein Zutaten zu diesem Gericht!" ]
                                    ]
                                ]
                            ]
                )
                recipeModel.recipe_list
            , [ div [ class "col-sm-6 col-md-6 col-lg-4 mb-5" ]
                    [ div []
                        [ h1 []
                            [ text "Neues Rezept" ]
                        , footer
                            []
                            [ button [] [ text "Neues Rezept erstellen" ] ]
                        , div
                            []
                            [ img [ src "placeholder", class "img-thumbnail", alt "image", width 100, height 10 ] []
                            ]
                        ]
                    ]
              ]
            ]
        )


dashboard : Model.Model -> List (Html Msg.Msg)
dashboard model =
    [ div [ class "w-full h-full" ]
        [ h1 []
            [ text "Dashboard" ]
        , text
            model.recipe_list.errorMsg
        , div []
            [ h1 []
                [ text "Rezepte" ]
            , div [ class "container" ] [ recipeListRenderer model.recipe_list ]
            ]
        ]
    ]
