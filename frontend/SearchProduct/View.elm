module SearchProduct.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import SearchProduct.Messages exposing (..)
import SearchProduct.Models exposing (SearchProduct)


view : SearchProduct -> Html Msg
view searchProduct =
    div []
        [ input [ placeholder "Search query", value (Maybe.withDefault "" searchProduct), type' "text", onInput UpdateSearch ] []
        , button [ onClick Click ] [ text "Buscar" ]
        ]
