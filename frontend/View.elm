module View exposing (..)

import Html exposing (Html, form, text)
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
                    Pages.Products.View.view model

                ConfirmationRoute ->
                    Pages.Confirmation.View.view model

                ReceiptRoute _ ->
                    Pages.Receipt.View.view model

                NotFoundRoute ->
                    notFoundView
    in
        [ Menu.View.view model
        , routedPage
        ]


notFoundView : Html Msg
notFoundView =
    text "Not Found"
