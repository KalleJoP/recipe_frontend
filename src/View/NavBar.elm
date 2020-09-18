module View.NavBar exposing (..)

import Bootstrap.Navbar as Navbar
import Html exposing (Html, text)
import Html.Attributes exposing (href)
import Model
import Msg


navBar : Model.Model -> Html Msg.Msg
navBar model =
    Navbar.config Msg.NavMsg
        |> Navbar.withAnimation
        |> Navbar.dark
        |> Navbar.fixBottom
        |> Navbar.container
        |> Navbar.brand [ href "/" ] [ text "Recipes" ]
        |> Navbar.items
            [ Navbar.itemLinkActive [ href "/create-food-item" ] [ text "Create Food Item" ]
            , Navbar.itemLinkActive [ href "/edit-food-item" ] [ text "Edit Food Item" ]
            ]
        |> Navbar.view model.navState
