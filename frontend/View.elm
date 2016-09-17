module View exposing (..)

import Html exposing (Html, div, text, button, a, ul, li, span)
import Html.App
import Html.Attributes exposing (class, href)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Pages.Products.View
import Pages.Confirmation.View
import Pages.Receipt.View
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
            [ menu model
            , routedPage
            ]


menu : Model -> Html Msg
menu { shouldShowConfirmationMenu } =
    div [ class "pure-menu pure-menu-horizontal" ]
        [ span [ class "pure-menu-heading" ]
            [ text "Sales On" ]
        , ul [ class "pure-menu-list" ]
            (menuItems shouldShowConfirmationMenu)
        ]


menuItems : Bool -> List (Html Msg)
menuItems shouldShowConfirmationMenu =
    --  TODO Still not sure how to be DRY here
    if shouldShowConfirmationMenu then
        [ li [ class "pure-menu-item" ]
            [ a [ class "pure-menu-link", href "#products" ]
                [ text "Productos" ]
            ]
        , li [ class "pure-menu-item" ]
            [ a [ class "pure-menu-link", href "#confirmation" ]
                [ text "Confirmación de Compra" ]
            ]
        ]
    else
        [ li [ class "pure-menu-item" ]
            [ a [ class "pure-menu-link", href "#products" ]
                [ text "Productos" ]
            ]
        ]


notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not Found"
        ]
