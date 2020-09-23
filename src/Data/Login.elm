module Data.Login exposing (..)


type alias Model =
    { username : String
    , password : String
    , session : String
    }


init : Model
init =
    { username = ""
    , password = ""
    , session = ""
    }


type Msg
    = UpdateUsername String
    | UpdatePassword String
    | PostLogin


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        UpdateUsername username ->
            ( { model | username = username }, Cmd.none )

        UpdatePassword password ->
            ( { model | password = password }, Cmd.none )

        PostLogin ->
            ( model, Cmd.none )
