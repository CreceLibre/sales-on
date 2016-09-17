module API.Resources.Cart exposing (saveTask, updateTask, deleteTask, fetchTask)

import Http
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
import Json.Decode.Pipeline as Pipeline
import Task
import API.Models exposing (ID, CartItem)


endpointUrl : String
endpointUrl =
    "/api/v1/cart"



-- Tasks


fetchTask : Task.Task Http.Error (List CartItem)
fetchTask =
    Http.get collectionDecoder endpointUrl


saveTask : ID -> Task.Task Http.Error ()
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


updateTask : ID -> Int -> Task.Task Http.Error ()
updateTask productId newQuantity =
    let
        body =
            encodeForUpdate productId newQuantity
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


deleteTask : ID -> Task.Task Http.Error ()
deleteTask productId =
    let
        body =
            encodeForDelete productId
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = "DELETE"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = endpointUrl
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson (Decode.succeed ())



-- Encoders


encodeForSave : ID -> Encode.Value
encodeForSave productId =
    let
        list =
            [ ( "product_id", Encode.int productId )
            ]
    in
        list
            |> Encode.object


encodeForDelete : ID -> Encode.Value
encodeForDelete productId =
    let
        list =
            [ ( "product_id", Encode.int productId )
            ]
    in
        list
            |> Encode.object


encodeForUpdate : ID -> Int -> Encode.Value
encodeForUpdate productId newQuantity =
    let
        list =
            [ ( "product_id", Encode.int productId )
            , ( "quantity", Encode.int newQuantity )
            ]
    in
        list
            |> Encode.object



-- Decoders


collectionDecoder : Decode.Decoder (List CartItem)
collectionDecoder =
    Decode.object1 identity
        ("items" := (Decode.list memberDecoder))


memberDecoder : Decode.Decoder CartItem
memberDecoder =
    Pipeline.decode CartItem
        |> Pipeline.required "product_id" Decode.int
        |> Pipeline.required "quantity" Decode.int
