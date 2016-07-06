module OrderBreakdown.Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Encode as Encode
import OrderBreakdown.Models exposing (OrderBreakdown, Item, ItemId)
import OrderBreakdown.Messages exposing (..)
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


decodeCartItem : Decode.Decoder Item
decodeCartItem =
    Pipeline.decode Item
        |> Pipeline.required "productId" Decode.int
        |> Pipeline.required "name" Decode.string
        |> Pipeline.required "unitPrice" decodeAmount
        |> Pipeline.required "total" decodeAmount
        |> Pipeline.required "quantity" Decode.int

updateItemUrl : String
updateItemUrl =
    "/api/v1/cart"


updateItemTask : ItemId -> Int -> Task.Task Http.Error ()
updateItemTask itemId newQuantity =
    let
        body =
            memberEncoded itemId newQuantity
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = "PUT"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = updateItemUrl
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson (Decode.succeed ())


updateItem : ItemId -> Int -> Cmd Msg
updateItem itemId newQuantity =
    updateItemTask itemId newQuantity
        |> Task.perform UpdateItemQuantityFail (always UpdateItemQuantityDone)


memberEncoded : ItemId -> Int -> Encode.Value
memberEncoded itemId newQuantity =
    let
        list =
            [ ( "product_id", Encode.int itemId )
            , ( "quantity", Encode.int newQuantity )
            ]
    in
        list
            |> Encode.object
