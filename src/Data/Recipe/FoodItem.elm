module Data.Recipe.FoodItem exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)


type alias Model =
    { id : Int
    , name : String
    , quantity_type : String
    }


init : Model
init =
    { id = 0
    , name = ""
    , quantity_type = ""
    }


foodItemDecoder : Decoder Model
foodItemDecoder =
    Decode.succeed Model
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "quantity_type" Decode.string
