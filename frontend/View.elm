module View exposing (..)

import Html exposing (Html, div, text, button, tr, td, table, th, tbody, thead, input, strong)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (class, disabled, placeholder, value, type')
import Messages exposing (Msg(..))
import Models exposing (..)
import Routing exposing (Route(..))
import Models exposing (Product)


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
                , productSearch model.searchProduct
                , listView model.products
                ]

        ConfirmationRoute ->
            div []
                [ nav "Confirmación de compra"
                , confirmationView model.confirmationOrder model.orderBreakdown
                ]

        ReceiptRoute _ ->
            div []
                [ nav "Orden completada"
                , receiptView model.receiptOrder
                ]

        NotFoundRoute ->
            notFoundView


confirmationView : ConfirmationOrder -> OrderBreakdown -> Html Msg
confirmationView confirmationOrder orderBreakdown =
    div []
        [ input [ placeholder "Correo", value confirmationOrder.email, type' "text", onInput UpdateEmail ] []
        , input [ placeholder "Metodo de pago", value confirmationOrder.paymentMethod, type' "text", onInput UpdatePaymentMethod ] []
        , input [ placeholder "Pickup", value confirmationOrder.pickupLocation, type' "text", onInput UpdatePickupLocation ] []
        , div []
            [ strong [] [ text "Método de Pago" ]
            ]
        , overview orderBreakdown
        , yourItems orderBreakdown
        , button [ onClick PlaceOrder ] [ text "Completar Pedido" ]
        ]


receiptView : Order' -> Html Msg
receiptView order =
    div []
        [ div []
            [ strong [] [ text ("Tu numero de pedido es " ++ toString (order.id) ++ ", te hemos enviado un correo con los detalles de tu pedido") ]
            ]
        ]


productSearch : Maybe String -> Html Msg
productSearch searchProduct =
    div []
        [ input [ placeholder "Search query", value (Maybe.withDefault "" searchProduct), type' "text", onInput UpdateSearch ] []
        , button [ onClick Click ] [ text "Buscar" ]
        ]


nav : String -> Html Msg
nav title =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ]
            [ text title ]
        , button [ onClick ShowConfirmation ] [ text "comprar" ]
        ]


notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not Found"
        ]


listView : List Product -> Html Msg
listView products =
    list products


list : List Product -> Html Msg
list products =
    if List.isEmpty products then
        text "No se encontraron productos"
    else
        div [ class "p2" ]
            [ table []
                [ thead []
                    [ tr []
                        [ th [] [ text "ID" ]
                        , th [] [ text "Name" ]
                        , th [] [ text "Category" ]
                        , th [] [ text "Price" ]
                        , th [] []
                        ]
                    ]
                , tbody [] (List.map productRow products)
                ]
            ]


productRow : Product -> Html Msg
productRow product =
    tr []
        [ td [] [ text (toString product.id) ]
        , td [] [ text (toString product.name) ]
        , td [] [ text (toString product.category) ]
        , td [] [ text (toString product.price) ]
        , td [] [ button [ onClick (AddToCart product.id), disabled (not product.addToCart) ] [ text "Add to cart" ] ]
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
