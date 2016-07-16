module ProductSearch.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import ProductSearch.Messages exposing (..)
import ProductSearch.Models exposing (ProductSearch)


view : ProductSearch -> Html Msg
view productSearch =
    div []
        [ input [ placeholder "Search query", value (Maybe.withDefault "" productSearch), type' "text", onInput UpdateSearch ] []
        , button [ onClick Click ] [ text "Buscar" ]
        ]
