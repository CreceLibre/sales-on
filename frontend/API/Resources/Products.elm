module API.Resources.Products exposing (fetchTask)

import Http
import Json.Decode as Decode exposing ((:=))
import Task


endpointUrl : String
endpointUrl =
    "/api/v1/products"


fetchTask : Maybe String -> Decode.Decoder a -> Task.Task Http.Error a
fetchTask query decoder =
    let
        url qs =
            case qs of
                Just term ->
                    endpointUrl ++ "?q=" ++ term

                Nothing ->
                    endpointUrl
    in
        Http.get decoder (url query)
