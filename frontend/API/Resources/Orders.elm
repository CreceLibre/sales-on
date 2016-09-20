module API.Resources.Orders exposing (fetchTask, saveTask)

import Http
import Json.Decode as Decode
import Task
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode


endpointUrl : String
endpointUrl =
    "/api/v1/orders"


fetchTask : String -> Decode.Decoder a -> Task.Task Http.Error a
fetchTask orderUuid decoder =
    let
        url qs =
            endpointUrl ++ "/" ++ qs
    in
        Http.get decoder (url orderUuid)


saveTask : Encode.Value -> Decode.Decoder a -> Task.Task Http.Error a
saveTask encoder decoder =
    let
        body =
            encoder
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
            |> Http.fromJson decoder
