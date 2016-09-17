module API.Resources.Breakdowns exposing (fetchTask)

import Http
import Json.Decode as Decode
import Task
import Json.Decode.Pipeline as Pipeline
import API.Models exposing (OrderBreakdown, OrderBreakdownItem)


endpointUrl : String
endpointUrl =
    "/api/v1/breakdowns"


fetchTask : Task.Task Http.Error OrderBreakdown
fetchTask =
    Http.get collectionDecoder endpointUrl


collectionDecoder : Decode.Decoder OrderBreakdown
collectionDecoder =
    Pipeline.decode identity
        |> Pipeline.required "breakdowns" breakdownsDecoder


breakdownsDecoder : Decode.Decoder OrderBreakdown
breakdownsDecoder =
    Pipeline.decode OrderBreakdown
        |> Pipeline.required "subtotal" decodeAmount
        |> Pipeline.required "total" decodeAmount
        |> Pipeline.required "items" (Decode.list decodeItem)


decodeAmount : Decode.Decoder String
decodeAmount =
    Pipeline.decode identity
        |> Pipeline.required "formattedAmount" Decode.string


decodeItem : Decode.Decoder OrderBreakdownItem
decodeItem =
    Pipeline.decode OrderBreakdownItem
        |> Pipeline.required "productId" Decode.int
        |> Pipeline.required "name" Decode.string
        |> Pipeline.required "unitPrice" decodeAmount
        |> Pipeline.required "total" decodeAmount
        |> Pipeline.required "quantity" Decode.int
