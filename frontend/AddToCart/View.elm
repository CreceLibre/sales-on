module AddToCart.View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import AddToCart.Messages exposing (..)
import AddToCart.Models exposing (AddToCart)


view : AddToCart -> Html Msg
view model =
    button [ onClick Add ] [ text "Add to cart" ]
