module OrderBreakdown.View exposing (..)

import Html exposing (..)
import OrderBreakdown.Messages exposing (..)
import OrderBreakdown.Models exposing (OrderBreakdown, Item)
import Html.Attributes exposing (class, disabled)
import Html.Events exposing (onClick)


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
        div [ class "p2" ]
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
