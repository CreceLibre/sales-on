module Pages.Receipt.Commands exposing (..)

import Pages.Receipt.Messages exposing (..)
import Task
import API.Resources.Orders as OrdersAPI


fetchOrder : String -> Cmd Msg
fetchOrder orderUuid =
    OrdersAPI.fetchTask orderUuid
        |> Task.perform FetchOrderFail FetchOrderSucceed
