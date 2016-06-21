module View exposing (..)

import Html exposing (Html, div, text)
import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model)
import Products.List
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        ProductsRoute ->
            Html.App.map ProductsMsg (Products.List.view model.products)

        NotFoundRoute ->
            notFoundView


notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not Found"
        ]
