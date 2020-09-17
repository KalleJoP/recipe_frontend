module Data.Recipe exposing (..)

import Data.Recipe.RecipeItem as RecipeItem
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (optional, required)


type alias Model =
    { errorMsg : String
    , recipe_list : List Recipe
    }


type alias Recipe =
    { id : Int
    , name : String
    , description : String
    , picture : String
    , recipe_items : List RecipeItem.Model
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { errorMsg = "", recipe_list = [] }
    , getRecipeList
    )


type Msg
    = RecieveRecipeList (Result Http.Error (List Recipe))
    | GetRecipeList


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RecieveRecipeList result ->
            case result of
                Ok recipe ->
                    ( { model | recipe_list = recipe }, Cmd.none )

                Err err ->
                    case err of
                        Http.BadBody errMsg ->
                            ( { model | errorMsg = "BadBody: " ++ errMsg }, Cmd.none )

                        Http.BadUrl errMsg ->
                            ( { model | errorMsg = errMsg }, Cmd.none )

                        Http.BadStatus errMsg ->
                            ( { model | errorMsg = String.fromInt errMsg }, Cmd.none )

                        Http.Timeout ->
                            ( model, Cmd.none )

                        Http.NetworkError ->
                            ( model, Cmd.none )

        GetRecipeList ->
            ( model, getRecipeList )



-- getRecipeList : Cmd Msg
-- getRecipeList =
--     Http.get
--         { url = "/api/recipes"
--         , expect = Http.expectJson RecieveRecipeList recipeDecoder
--         }


getRecipeList : Cmd Msg
getRecipeList =
    Http.get
        { url = "/api/recipes"
        , expect = Http.expectJson RecieveRecipeList recipeListDecoder
        }


recipeListDecoder : Decode.Decoder (List Recipe)
recipeListDecoder =
    Decode.list recipeDecoder


recipeDecoder : Decoder Recipe
recipeDecoder =
    Decode.succeed Recipe
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "description" Decode.string
        |> optional "picture" Decode.string ""
        |> optional "recipe_items" RecipeItem.recipeItemListDecoder []
