module Commands exposing (..)

import Messages exposing (Msg(..))
import Task
import API.Resources.Orders as OrdersAPI


fetchOrder : String -> Cmd Msg
fetchOrder orderUuid =
    OrdersAPI.fetchTask orderUuid
        |> Task.perform FetchOrderFail FetchOrderSucceed
