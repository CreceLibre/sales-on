module API.Resources.Products exposing (fetchTask)

import Http
import Json.Decode as Decode exposing ((:=))
import Products.Models exposing (ProductId, Product)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Task

endpointUrl : String
endpointUrl =
    "/api/v1/products"


fetchAllUrl : Maybe String -> String
fetchAllUrl qs =
    case qs of
        Just term ->
            endpointUrl ++ "?q=" ++ term

        Nothing ->
            endpointUrl


fetchTask : Maybe String -> Task.Task Http.Error (List Product)
fetchTask query =
    Http.get collectionDecoder (fetchAllUrl query)


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
