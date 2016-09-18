module View exposing (..)

import Html exposing (Html, form, text)
import Html.Attributes exposing (class)
import Messages exposing (Msg(..))
import State exposing (State)
import Views.Products
import Views.Confirmation
import Views.Receipt
import Views.Menu
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
                    Views.Products.view model

                ConfirmationRoute ->
                    Views.Confirmation.view model

                ReceiptRoute _ ->
                    Views.Receipt.view model

                NotFoundRoute ->
                    notFoundView
    in
        [ Views.Menu.view model
        , routedPage
        ]


notFoundView : Html Msg
notFoundView =
    text "Not Found"
