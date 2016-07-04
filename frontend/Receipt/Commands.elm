module Receipt.Commands exposing (..)

import Http
import Json.Decode as Decode
import Receipt.Models exposing (Order')
import Receipt.Messages exposing (..)
import Task
import Json.Decode.Pipeline as Pipeline


fetchOrderUrl : String -> String
fetchOrderUrl orderUuid =
    "http://localhost:9292/api/v1/orders/" ++ orderUuid


fetchOrder : String -> Cmd Msg
fetchOrder orderUuid =
    Http.get collectionDecoder (fetchOrderUrl orderUuid)
        |> Task.perform FetchOrderFail FetchOrderDone


collectionDecoder : Decode.Decoder Order'
collectionDecoder =
    Pipeline.decode identity
        |> Pipeline.required "order" orderDecoder


orderDecoder : Decode.Decoder Order'
orderDecoder =
    Pipeline.decode Order'
        |> Pipeline.required "id" Decode.int
        |> Pipeline.required "email" Decode.string
