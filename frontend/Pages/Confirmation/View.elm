module Pages.Confirmation.View exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Pages.Confirmation.Messages exposing (..)
import Pages.Confirmation.Models exposing (ConfirmationOrder)
import OrderBreakdown.View


view : ConfirmationOrder -> Html Msg
view confirmationOrder =
    div []
        [ input [ placeholder "Correo", value confirmationOrder.email, type' "text", onInput UpdateEmail ] []
        , input [ placeholder "Metodo de pago", value confirmationOrder.paymentMethod, type' "text", onInput UpdatePaymentMethod ] []
        , input [ placeholder "Pickup", value confirmationOrder.pickupLocation, type' "text", onInput UpdatePickupLocation ] []
        , div []
            [ strong [] [ text "Método de Pago" ]
            ]
        , Html.App.map OrderBreakdownMsg (OrderBreakdown.View.overview confirmationOrder.orderBreakdown)
        , Html.App.map OrderBreakdownMsg (OrderBreakdown.View.yourItems confirmationOrder.orderBreakdown)
        , button [ onClick PlaceOrder ] [ text "Completar Pedido" ]
        ]
