module Products.Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Products.Models exposing (ProductId, Product)
import Products.Messages exposing (..)
import Task

fetchAll : Cmd Msg
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.perform FetchAllFail FetchAllDone

fetchAllUrl : String
fetchAllUrl =
  "http://localhost:9292/api/v1/products"

collectionDecoder : Decode.Decoder (List Product)
collectionDecoder =
  Decode.object1 identity
    ("products" := (Decode.list memberDecoder))


memberDecoder : Decode.Decoder Product
memberDecoder =
  Decode.object4 Product
    ("id" := Decode.int)
    ("name" := Decode.string)
    ("category" := Decode.string)
    ("price" := Decode.int)
