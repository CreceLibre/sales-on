module API.Resources.Breakdowns exposing (fetchTask)

import Http
import Json.Decode as Decode
import Task


endpointUrl : String
endpointUrl =
    "/api/v1/breakdowns"


fetchTask : Decode.Decoder a -> Task.Task Http.Error a
fetchTask decoder =
    Http.get decoder endpointUrl
