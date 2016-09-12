module Pages.Confirmation.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick, on, targetValue)
import Pages.Confirmation.Messages exposing (..)
import Pages.Confirmation.Models exposing (ConfirmationPageModel)
import API.Models exposing (OrderBreakdown, Item)
import Html.Keyed as Keyed
import Html.Lazy exposing (lazy)
import Utils exposing (onChangeIntValue)


view : ConfirmationPageModel -> Html Msg
view { orderConfirmation, orderBreakdown } =
    div [ class "center" ]
        [ Html.form [ class "pure-g pure-form" ]
            [ rightContent orderBreakdown
            , leftContent orderBreakdown
            ]
        ]


rightContent : OrderBreakdown -> Html Msg
rightContent orderBreakdown =
    div [ class "pure-u-1 pure-u-sm-2-3" ]
        [ userModule
        , paymentModule
        , itemsModule orderBreakdown
        ]


leftContent : OrderBreakdown -> Html Msg
leftContent orderBreakdown =
    div [ class "pure-u-1 pure-u-sm-1-3" ]
        [ overviewModule orderBreakdown
        ]


userModule : Html Msg
userModule =
    div [ class "module " ]
        [ h3 []
            [ text "Tus Datos" ]
        , div
            [ class "body" ]
            [ div [ class "block" ]
                [ div [ class "field" ]
                    [ input [ type' "email", placeholder "tu@correo.com", id "email", onInput UpdateEmail ] []
                    , label [ for "email" ]
                        [ text "E-mail" ]
                    ]
                ]
            ]
        ]


paymentModule : Html Msg
paymentModule =
    div [ class "module" ]
        [ h3 []
            [ text "Método de Pago" ]
        , div
            [ class "body" ]
            [ div [ class "block" ]
                [ label [ class "pure-g" ]
                    [ div [ class "pure-u-1-24 payment-method-radio" ]
                        [ input [ type' "radio", checked True ] []
                        ]
                    , div [ class "pure-u-23-24 payment-method" ]
                        [ img [ class "pure-img", src "http://medula.cl/blog/wp-content/uploads/2012/03/webpay-plus-horizontal1.png" ] []
                        ]
                    ]
                ]
            ]
        ]


itemsModule : OrderBreakdown -> Html Msg
itemsModule { items } =
    div [ class "module " ]
        [ h3 []
            [ text "Tus Items" ]
        , div
            [ class "body" ]
            (List.map itemRow items)
        ]


overviewModule : OrderBreakdown -> Html Msg
overviewModule { subtotal, total } =
    div [ class "module" ]
        [ h3 []
            [ text "Información de compra" ]
        , div
            [ class "body" ]
            [ div [ class "block" ]
                [ div [ class "pure-g" ]
                    [ div [ class "pure-u-3-5" ] [ text "Subtotal:" ]
                    , div [ class "pure-u-2-5 text-align-right" ] [ text subtotal ]
                    , div [ class "pure-u-1" ] [ hr [] [] ]
                    , div [ class "pure-u-3-5" ] [ text "Total:" ]
                    , div [ class "pure-u-2-5 text-align-right" ] [ text total ]
                    , div [ class "pure-u-1" ] [ a [ class "button-large pure-button", onClick PlaceOrder ] [ text "Completar pedido" ] ]
                    ]
                ]
            ]
        ]


keyedSelect : List (Attribute msg) -> List ( String, Html msg ) -> Html msg
keyedSelect =
    Keyed.node "select"


itemRow : Item -> Html Msg
itemRow item =
    let
        getQuantityOption quantity x =
            option [ value (toString x), selected (quantity == x) ] [ text (toString x) ]

        viewKeyedEntry quantity x =
            ( (toString x) ++ " " ++ (toString quantity), lazy (getQuantityOption quantity) x )
    in
        div [ class "block" ]
            [ div [ class "pure-g" ]
                [ div [ class "pure-u-2-5 pure-u-sm-1-5" ]
                    [ img [ class "pure-img", src "http://placehold.it/150x100" ] []
                    ]
                , div [ class "pure-u-2-5 pure-u-sm-3-5" ]
                    [ div [ class "item-main" ]
                        [ div [ class "pure-u-1 item-title" ]
                            [ text item.name ]
                        , div
                            [ class "pure-u-3-5 pure-u-sm-1-5 item-quantity" ]
                            [ text "Cantidad:"
                            ]
                        , div
                            [ class "pure-u-2-5 pure-u-sm-4-5" ]
                            [ keyedSelect [ onChangeIntValue (ChangeQuantity item.id) ] <|
                                (List.map (viewKeyedEntry item.quantity) [1..5])
                            ]
                        , div
                            []
                            [ a [] [ text ("Quitar" ++ " " ++ (toString item.quantity)) ] ]
                        ]
                    ]
                , div [ class "pure-u-1-5 pure-u-sm-1-5" ]
                    [ div [ class "item-price text-align-right" ]
                        [ text item.unitPrice
                        ]
                    ]
                ]
            ]
