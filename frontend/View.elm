module View exposing (..)

import Html exposing (Html, div, text, button)
import Html.App
import Html.Events exposing (onClick)
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
    case model.route of
        ProductsRoute ->
            div []
                [ nav "Products"
                , Html.App.map ProductsMsg (Pages.Products.View.view model.productsPage)
                ]

        ConfirmationRoute ->
            div []
                [ nav "Confirmación de compra"
                , Html.App.map ConfirmationMsg (Pages.Confirmation.View.view model.confirmationPage)
                ]

        ReceiptRoute _ ->
            div []
                [ nav "Orden completada"
                , Html.App.map ReceiptMsg (Pages.Receipt.View.view model.receiptPage)
                ]

        NotFoundRoute ->
            notFoundView


nav : String -> Html Msg
nav title =
    div [ ]
        [ div [ ]
            [ text title ]
        , button [ onClick ShowConfirmation ] [ text "comprar" ]
        ]


notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not Found"
        ]
