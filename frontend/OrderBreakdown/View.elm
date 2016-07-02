module OrderBreakdown.View exposing (..)

import Html exposing (..)
import Html.App
import OrderBreakdown.Messages exposing (..)
import OrderBreakdown.Models exposing (OrderBreakdown)
import CartItems.List


yourItems : OrderBreakdown -> Html Msg
yourItems orderBreakdown =
    div []
        [ div []
            [ strong [] [ text "Tus items" ]
            , Html.App.map CartItemsMsg (CartItems.List.view orderBreakdown.cartItems)
            ]
        ]


overview : OrderBreakdown -> Html Msg
overview orderBreakdown =
    div []
        [ div []
            [ strong [] [ text "Resumen del pedido" ] ]
        , div []
            [ strong [] [ text ("Subtotal" ++ orderBreakdown.subtotal) ] ]
        , div []
            [ strong [] [ text ("total" ++ orderBreakdown.total) ] ]
        ]
