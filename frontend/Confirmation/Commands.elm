module Confirmation.Commands exposing (..)

import Http
import Task
import Confirmation.Messages exposing (..)
import Confirmation.Models exposing (ConfirmationOrder)
import Json.Encode as Encode
import Json.Decode as Decode exposing ((:=))
import OrderBreakdown.Commands


fetchAll : Cmd Msg
fetchAll =
    Cmd.map OrderBreakdownMsg OrderBreakdown.Commands.fetchAll


placeOrderUrl : String
placeOrderUrl =
    "http://localhost:9292/api/v1/orders"


placeOrderTask : ConfirmationOrder -> Task.Task Http.Error String
placeOrderTask confirmationOrder =
    let
        body =
            memberEncoded confirmationOrder
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = "POST"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = placeOrderUrl
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson decodeOrderResult


decodeOrderResult : Decode.Decoder String
decodeOrderResult =
    Decode.object1 identity
        ("order" := decodeOrderId)


decodeOrderId : Decode.Decoder String
decodeOrderId =
    Decode.object1 identity
        ("uuid" := Decode.string)


placeOrder : ConfirmationOrder -> Cmd Msg
placeOrder confirmationOrder =
    placeOrderTask confirmationOrder
        |> Task.perform PlaceOrderFail PlaceOrderDone


memberEncoded : ConfirmationOrder -> Encode.Value
memberEncoded confirmationOrder =
    let
        list =
            [ ( "email", Encode.string confirmationOrder.email )
            , ( "payment_method", Encode.string confirmationOrder.paymentMethod )
            , ( "pickup_location", Encode.string confirmationOrder.pickupLocation )
            ]
    in
        list
            |> Encode.object
