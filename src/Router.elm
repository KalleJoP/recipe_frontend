module Router exposing (..)

import Url


type Route
    = Login
    | Dashboard


nextRoute : Url.Url -> Route
nextRoute url =
    case url.path of
        _ ->
            Dashboard
