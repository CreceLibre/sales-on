module Confirmation.Commands exposing (..)

import Http
import Json.Decode as Decode
import Confirmation.Models exposing (ConfirmationOrder)
import Shared.Models exposing (Amount)
import Confirmation.Messages exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import CartItems.Models exposing (CartItem)
import Task


fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchBreakdownsFail FetchBreakdownsDone


fetchAllUrl : String
fetchAllUrl  =
    "http://localhost:9292/api/v1/breakdowns"


collectionDecoder : Decode.Decoder ConfirmationOrder
collectionDecoder =
    decode identity
      |> required "breakdowns" breakdownsDecoder

breakdownsDecoder : Decode.Decoder ConfirmationOrder
breakdownsDecoder =
    decode ConfirmationOrder
        |> hardcoded ""
        |> hardcoded ""
        |> hardcoded ""
        |> required "subtotal" decodeAmount
        |> required "total" decodeAmount
        |> required "items" (Decode.list decodeCartItem)

decodeAmount : Decode.Decoder Amount
decodeAmount =
  decode Amount
    |> required "currencyCode" Decode.string
    |> required "amount" Decode.int
    |> required "formattedAmount" Decode.string

decodeCartItem : Decode.Decoder CartItem
decodeCartItem =
  decode CartItem
    |> required "productId" Decode.int
    |> required "name" Decode.string
    |> required "unitPrice" decodeAmount
    |> required "total" decodeAmount
    |> required "quantity" Decode.int
