module Pages.Confirmation.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Pages.Confirmation.Messages exposing (..)
import Pages.Confirmation.Models exposing (ConfirmationPageModel)
import API.Models exposing (OrderBreakdown, Item)


view : ConfirmationPageModel -> Html Msg
view { orderConfirmation, orderBreakdown } =
    div []
        [ input [ placeholder "Correo", value orderConfirmation.email, type' "text", onInput UpdateEmail ] []
        , input [ placeholder "Metodo de pago", value orderConfirmation.paymentMethod, type' "text", onInput UpdatePaymentMethod ] []
        , input [ placeholder "Pickup", value orderConfirmation.pickupLocation, type' "text", onInput UpdatePickupLocation ] []
        , div []
            [ strong [] [ text "Método de Pago" ]
            ]
        , overview orderBreakdown
        , yourItems orderBreakdown
        , button [ onClick PlaceOrder ] [ text "Completar Pedido" ]
        ]


yourItems : OrderBreakdown -> Html Msg
yourItems orderBreakdown =
    div []
        [ div []
            [ strong [] [ text "Tus items" ]
            , itemList orderBreakdown.items
            ]
        ]


itemList : List Item -> Html Msg
itemList items =
    if List.isEmpty items then
        text "No se encontraron productos :("
    else
        div []
            [ table []
                [ thead []
                    [ tr []
                        [ th [] [ text "ID" ]
                        , th [] [ text "Name" ]
                        , th [] [ text "Price" ]
                        , th [] [ text "Quantity" ]
                        , th [] [ text "Total" ]
                        , th [] []
                        ]
                    ]
                , tbody [] (List.map itemRow items)
                ]
            ]


itemRow : Item -> Html Msg
itemRow item =
    tr []
        [ td [] [ text (toString item.id) ]
        , td [] [ text (item.name) ]
        , td [] [ text (item.unitPrice) ]
        , td [] [ text (toString item.quantity) ]
        , td [] [ text (item.total) ]
        , td []
            [ button [ onClick (IncreaseQuantity item.id) ] [ text "+" ]
            , button [ onClick (DecreaseQuantity item.id) ] [ text "-" ]
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
