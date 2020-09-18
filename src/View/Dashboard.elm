module View.Dashboard exposing (..)

import Bootstrap.Button as Button
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.ListGroup as ListGroup
import Data.Recipe as Recipe
import Data.Recipe.RecipeItem as RecipeItem
import Html exposing (Html, button, div, h1, img, li, p, text, ul)
import Html.Attributes exposing (alt, class, height, src, width)
import Model
import Msg


recipeItemListRenderer : List RecipeItem.Model -> Html Msg.Msg
recipeItemListRenderer recipeItemModelList =
    ListGroup.ul
        (List.indexedMap
            (\_ recipeItem ->
                ListGroup.li []
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
        (List.indexedMap
            (\_ recipe ->
                if List.length recipe.recipe_items /= 0 then
                    div [ class "col-sm-6 col-md-6 col-lg-4" ]
                        [ Card.config
                            [ Card.outlineInfo ]
                            |> Card.headerH1 [] [ text recipe.name ]
                            |> Card.footer [] [ Button.button [ Button.success ] [ text "Add to list" ] ]
                            |> Card.block []
                                [ Block.custom (img [ src recipe.picture, class "img-thumbnail", alt "image", width 100, height 10 ] [])
                                , Block.custom (recipeItemListRenderer recipe.recipe_items)
                                ]
                            |> Card.view
                        ]

                else
                    div [ class "col-sm-6 col-md-4 col-lg-4" ]
                        [ div [ class "card mb-4 box-shadow" ]
                            [ div [ class "card-header" ]
                                [ h1 [] [ text recipe.name ]
                                ]
                            , div [ class "card-body" ]
                                [ img [ src recipe.picture, class "img-thumbnail", alt "image", width 100 ] []
                                , p [ class "card-text" ] [ text "Keine Zutaten zu diesem Gericht" ]
                                ]
                            ]
                        ]
            )
            recipeModel.recipe_list
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
