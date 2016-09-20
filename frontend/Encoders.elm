module Encoders
    exposing
        ( saveCartItemEncoder
        , deleteCartItemEncoder
        , updateItemEncoder
        , saveOrderEncoder
        )

import Json.Encode as Encode
import API.Models exposing (ID, OrderConfirmation)


saveCartItemEncoder : ID -> Encode.Value
saveCartItemEncoder productId =
    let
        list =
            [ ( "product_id", Encode.int productId )
            ]
    in
        list
            |> Encode.object


deleteCartItemEncoder : ID -> Encode.Value
deleteCartItemEncoder productId =
    let
        list =
            [ ( "product_id", Encode.int productId )
            ]
    in
        list
            |> Encode.object


updateItemEncoder : ID -> Int -> Encode.Value
updateItemEncoder productId newQuantity =
    let
        list =
            [ ( "product_id", Encode.int productId )
            , ( "quantity", Encode.int newQuantity )
            ]
    in
        list
            |> Encode.object


saveOrderEncoder : OrderConfirmation -> Encode.Value
saveOrderEncoder confirmationOrder =
    let
        list =
            [ ( "email", Encode.string confirmationOrder.email )
            , ( "payment_method", Encode.string confirmationOrder.paymentMethod )
            , ( "pickup_location", Encode.string confirmationOrder.pickupLocation )
            ]
    in
        list
            |> Encode.object
