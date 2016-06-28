module Products.Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Products.Models exposing (ProductId, Product)
import Products.Messages exposing (..)
import Json.Encode as Encode
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Task


addToCartUrl : String
addToCartUrl =
    "http://localhost:9292/api/v1/cart"


addToCartTask : ProductId -> Task.Task Http.Error ()
addToCartTask productId =
    let
        body =
            memberEncoded productId
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = "POST"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = addToCartUrl
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson (Decode.succeed ())


addProductToCart : ProductId -> Cmd Msg
addProductToCart productId =
    addToCartTask productId
        |> Task.perform AddToCartFail (always AddToCartSuccess)


memberEncoded : ProductId -> Encode.Value
memberEncoded productId =
    let
        list =
            [ ( "product_id", Encode.int productId )
            ]
    in
        list
            |> Encode.object


fetchAll : Maybe String -> Cmd Msg
fetchAll query =
    Http.get collectionDecoder (fetchAllUrl query)
        |> Task.perform FetchAllFail FetchAllDone


fetchAllUrl : Maybe String -> String
fetchAllUrl query =
    case query of
        Just term ->
            "http://localhost:9292/api/v1/products?q=" ++ term

        Nothing ->
            "http://localhost:9292/api/v1/products"


collectionDecoder : Decode.Decoder (List Product)
collectionDecoder =
    Decode.object1 identity
        ("products" := (Decode.list memberDecoder))


memberDecoder : Decode.Decoder Product
memberDecoder =
    decode Product
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "category" Decode.string
        |> required "price" Decode.int
        |> hardcoded True
