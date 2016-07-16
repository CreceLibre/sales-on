module API.Resources.Products exposing (fetchTask)

import Http
import Json.Decode as Decode exposing ((:=))
import Models exposing (ProductId, Product)
import Json.Decode.Pipeline as Pipeline
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
    Pipeline.decode Product
        |> Pipeline.required "id" Decode.int
        |> Pipeline.required "name" Decode.string
        |> Pipeline.required "category" Decode.string
        |> Pipeline.required "price" Decode.int
        |> Pipeline.hardcoded True
