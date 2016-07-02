module Confirmation.View exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Confirmation.Messages exposing (..)
import Confirmation.Models exposing (ConfirmationOrder)
import CartItems.List


view : ConfirmationOrder -> Html Msg
view confirmationOrder =
    div []
        [ input [ placeholder "Correo", value confirmationOrder.email, type' "text", onInput UpdateEmail ] []
        , div []
            [ strong [] [ text "Método de Pago" ]
            ]
        , div []
            [ strong [] [ text "Resumen del pedido" ] ]
        , div []
            [ strong [] [ text ("Subtotal"++confirmationOrder.subtotal.formattedAmount) ] ]
        , div []
            [ strong [] [ text ("total"++confirmationOrder.total.formattedAmount) ] ]
        , div []
            [ strong [] [ text "Tus items" ]
            , Html.App.map CartItemsMsg (CartItems.List.view confirmationOrder.cartItems)
            ]
        ]
