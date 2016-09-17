module View exposing (..)

import Html exposing (Html, div, text, button, a, ul, li, span)
import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model)
import Pages.Products.View
import Pages.Confirmation.View
import Pages.Receipt.View
import Menu.View
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    let
        routedPage =
            case model.route of
                ProductsRoute ->
                    Html.App.map ProductsMsg (Pages.Products.View.view model.productsPage)

                ConfirmationRoute ->
                    Html.App.map ConfirmationMsg (Pages.Confirmation.View.view model.confirmationPage)

                ReceiptRoute _ ->
                    Html.App.map ReceiptMsg (Pages.Receipt.View.view model.receiptPage)

                NotFoundRoute ->
                    notFoundView
    in
        div []
            [ Html.App.map MenuMsg (Menu.View.view model.menu model.route)
            , routedPage
            ]


notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not Found"
        ]
