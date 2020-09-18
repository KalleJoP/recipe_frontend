module Data.Recipe.FoodItem exposing (..)

import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)
import Json.Encode as Encode


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


type Msg
    = UpdateName String
    | UpdateQuantityType String
    | SaveFoodItem
    | RecieveFoodItem (Result Http.Error Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateName name ->
            ( { model | name = name }, Cmd.none )

        UpdateQuantityType qType ->
            ( { model | quantity_type = qType }, Cmd.none )

        SaveFoodItem ->
            ( model, saveFoodItem model )

        RecieveFoodItem result ->
            case result of
                Ok _ ->
                    --TODO: replace model maybe
                    ( model, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )


saveFoodItem : Model -> Cmd Msg
saveFoodItem model =
    Http.post
        { url = "/api/food_items"
        , body = Http.jsonBody (foodItemEncodeObject model)
        , expect = Http.expectJson RecieveFoodItem foodItemDecoder
        }


foodItemDecoder : Decoder Model
foodItemDecoder =
    Decode.succeed Model
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "quantity_type" Decode.string


foodItemEncodeObject : Model -> Encode.Value
foodItemEncodeObject model =
    Encode.object
        [ ( "food_item", foodItemEncode model )
        ]


foodItemEncode : Model -> Encode.Value
foodItemEncode model =
    Encode.object
        [ ( "name", Encode.string model.name )
        , ( "quantity_type", Encode.string model.quantity_type )
        ]
