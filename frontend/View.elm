module View exposing (..)

import Html exposing (Html, div, text)
import Html.App
import Html.Attributes exposing (class)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Products.List
import SearchProduct.View
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        ProductsRoute ->
            div []
                [ nav
                , Html.App.map SearchProductMsg (SearchProduct.View.view model.searchProduct)
                , Html.App.map ProductsMsg (Products.List.view model.products)
                ]

        NotFoundRoute ->
            notFoundView


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ]
            [ text "Products" ]
        ]


notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not Found"
        ]
