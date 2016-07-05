module OrderBreakdown.Commands exposing (..)

import Http
import Json.Decode as Decode
import OrderBreakdown.Models exposing (OrderBreakdown)
import OrderBreakdown.Messages exposing (..)
import CartItems.Models exposing (CartItem)
import Task
import Json.Decode.Pipeline as Pipeline


fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchBreakdownsFail FetchBreakdownsDone


fetchAllUrl : String
fetchAllUrl =
    "/api/v1/breakdowns"


collectionDecoder : Decode.Decoder OrderBreakdown
collectionDecoder =
    Pipeline.decode identity
        |> Pipeline.required "breakdowns" breakdownsDecoder


breakdownsDecoder : Decode.Decoder OrderBreakdown
breakdownsDecoder =
    Pipeline.decode OrderBreakdown
        |> Pipeline.required "subtotal" decodeAmount
        |> Pipeline.required "total" decodeAmount
        |> Pipeline.required "items" (Decode.list decodeCartItem)


decodeAmount : Decode.Decoder String
decodeAmount =
    Pipeline.decode identity
        |> Pipeline.required "formattedAmount" Decode.string


decodeCartItem : Decode.Decoder CartItem
decodeCartItem =
    Pipeline.decode CartItem
        |> Pipeline.required "productId" Decode.int
        |> Pipeline.required "name" Decode.string
        |> Pipeline.required "unitPrice" decodeAmount
        |> Pipeline.required "total" decodeAmount
        |> Pipeline.required "quantity" Decode.int
