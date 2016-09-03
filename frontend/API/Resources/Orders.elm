module API.Resources.Orders exposing (fetchTask, saveTask)

import Http
import Json.Decode as Decode
import API.Models exposing (Order')
import Pages.Confirmation.Models exposing (ConfirmationOrder)
import Task
import Json.Decode.Pipeline as Pipeline
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode


endpointUrl : String
endpointUrl =
    "/api/v1/orders"


fetchUrl : String -> String
fetchUrl qs =
    endpointUrl ++ "/" ++ qs


fetchTask : String -> Task.Task Http.Error Order'
fetchTask orderUuid =
    Http.get collectionDecoder (fetchUrl orderUuid)


collectionDecoder : Decode.Decoder Order'
collectionDecoder =
    Pipeline.decode identity
        |> Pipeline.required "order" orderDecoder


orderDecoder : Decode.Decoder Order'
orderDecoder =
    Pipeline.decode Order'
        |> Pipeline.required "id" Decode.int
        |> Pipeline.required "email" Decode.string


saveTask : ConfirmationOrder -> Task.Task Http.Error String
saveTask confirmationOrder =
    let
        body =
            memberEncoded confirmationOrder
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = "POST"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = endpointUrl
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
