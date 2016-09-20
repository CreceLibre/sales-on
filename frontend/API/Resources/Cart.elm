module API.Resources.Cart exposing (saveTask, updateTask, deleteTask, fetchTask)

import Http
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
import Task


endpointUrl : String
endpointUrl =
    "/api/v1/cart"



-- Tasks


fetchTask : Decode.Decoder a -> Task.Task Http.Error a
fetchTask decoder =
    Http.get decoder endpointUrl


saveTask : Encode.Value -> Task.Task Http.Error ()
saveTask encoder =
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
            |> Http.fromJson (Decode.succeed ())


updateTask : Encode.Value -> Task.Task Http.Error ()
updateTask encoder =
    let
        body =
            encoder
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


deleteTask : Encode.Value -> Task.Task Http.Error ()
deleteTask encoder =
    let
        body =
            encoder
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
