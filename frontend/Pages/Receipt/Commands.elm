module Pages.Receipt.Commands exposing (..)

import Pages.Receipt.Messages exposing (..)
import Task
import API.Resources.Orders as OrdersAPI


fetch : String -> Cmd Msg
fetch orderUuid =
    OrdersAPI.fetchTask orderUuid
        |> Task.perform FetchOrderFail FetchOrderDone
