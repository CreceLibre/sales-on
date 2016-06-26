module Products.Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Products.Models exposing (ProductId, Product)
import Products.Messages exposing (..)
import AddToCart.Models
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Task

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
    |> hardcoded AddToCart.Models.init
