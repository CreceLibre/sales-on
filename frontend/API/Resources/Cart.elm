module API.Resources.Cart exposing (saveTask, updateTask)

import Http
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
import Task


endpointUrl : String
endpointUrl =
    "/api/v1/cart"


saveTask : Int -> Task.Task Http.Error ()
saveTask productId =
    let
        body =
            encodeForSave productId
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
            |> Http.fromJson (Decode.succeed ())


encodeForSave : Int -> Encode.Value
encodeForSave productId =
    let
        list =
            [ ( "product_id", Encode.int productId )
            ]
    in
        list
            |> Encode.object


updateTask : Int -> Int -> Task.Task Http.Error ()
updateTask itemId newQuantity =
    let
        body =
            encodeForUpdate itemId newQuantity
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = "PUT"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = endpointUrl
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson (Decode.succeed ())


encodeForUpdate : Int -> Int -> Encode.Value
encodeForUpdate itemId newQuantity =
    let
        list =
            [ ( "product_id", Encode.int itemId )
            , ( "quantity", Encode.int newQuantity )
            ]
    in
        list
            |> Encode.object
