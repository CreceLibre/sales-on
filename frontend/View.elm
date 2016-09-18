module View exposing (..)

import Html.App
import Html exposing (Html, form, div, text)
import Html.Attributes exposing (class)
import Messages exposing (Msg(..))
import Models exposing (State)
import Pages.Products.View
import Pages.Confirmation.View
import Pages.Receipt.View
import Menu.View
import Routing exposing (Route(..))


view : State -> Html Msg
view model =
    form [ class "pure-form" ] <| page model


page : State -> List (Html Msg)
page model =
    let
        routedPage =
            case model.route of
                ProductsRoute ->
                    Html.App.map ProductsMsg <| Pages.Products.View.view model.productsPage

                ConfirmationRoute ->
                    Html.App.map ConfirmationMsg <| Pages.Confirmation.View.view model.confirmationPage

                ReceiptRoute _ ->
                    Pages.Receipt.View.view model

                NotFoundRoute ->
                    notFoundView
    in
        [ Html.App.map MenuMsg <| Menu.View.view model.menu model.route
        , routedPage
        ]


notFoundView : Html Msg
notFoundView =
    text "Not Found"
