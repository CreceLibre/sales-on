module Menu.Commands exposing (..)

import Task
import Menu.Messages exposing (..)
import API.Resources.Cart as CartAPI


fetchCart : Cmd Msg
fetchCart =
    CartAPI.fetchTask
        |> Task.perform FetchAllFail FetchAllDone
