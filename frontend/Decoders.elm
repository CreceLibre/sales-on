module Decoders
    exposing
        ( breakdownsCollectionDecoder
        , cartItemCollectionDecoder
        , orderReceiptDecoder
        , productCollectionDecoder
        )

import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline
import API.Models
    exposing
        ( OrderBreakdown
        , OrderBreakdownItem
        , CartItem
        , OrderReceipt
        , Product
        )


breakdownsCollectionDecoder : Decode.Decoder OrderBreakdown
breakdownsCollectionDecoder =
    Pipeline.decode identity
        |> Pipeline.required "breakdowns"
            (Pipeline.decode OrderBreakdown
                |> Pipeline.required "subtotal" amountDecoder
                |> Pipeline.required "total" amountDecoder
                |> Pipeline.required "items" (Decode.list breakdownsItemDecoder)
            )


breakdownsItemDecoder : Decode.Decoder OrderBreakdownItem
breakdownsItemDecoder =
    Pipeline.decode OrderBreakdownItem
        |> Pipeline.required "productId" Decode.int
        |> Pipeline.required "name" Decode.string
        |> Pipeline.required "unitPrice" amountDecoder
        |> Pipeline.required "total" amountDecoder
        |> Pipeline.required "quantity" Decode.int


amountDecoder : Decode.Decoder String
amountDecoder =
    Pipeline.decode identity
        |> Pipeline.required "formattedAmount" Decode.string


cartItemCollectionDecoder : Decode.Decoder (List CartItem)
cartItemCollectionDecoder =
    Pipeline.decode identity
        |> Pipeline.required "items" (Decode.list cartItemDecoder)


cartItemDecoder : Decode.Decoder CartItem
cartItemDecoder =
    Pipeline.decode CartItem
        |> Pipeline.required "product_id" Decode.int
        |> Pipeline.required "quantity" Decode.int


orderReceiptDecoder : Decode.Decoder OrderReceipt
orderReceiptDecoder =
    Pipeline.decode identity
        |> Pipeline.required "order"
            (Pipeline.decode OrderReceipt
                |> Pipeline.required "id" Decode.int
                |> Pipeline.required "email" Decode.string
                |> Pipeline.required "uuid" Decode.string
            )


productCollectionDecoder : Decode.Decoder (List Product)
productCollectionDecoder =
    Pipeline.decode identity
        |> Pipeline.required "products" (Decode.list productDecoder)


productDecoder : Decode.Decoder Product
productDecoder =
    Pipeline.decode Product
        |> Pipeline.required "id" Decode.int
        |> Pipeline.required "name" Decode.string
        |> Pipeline.required "category" Decode.string
        |> Pipeline.required "price" priceDecoder
        |> Pipeline.required "isInCart" Decode.bool


priceDecoder : Decode.Decoder String
priceDecoder =
    Pipeline.decode identity
        |> Pipeline.required "formattedAmount" Decode.string
