module Confirmation.Commands exposing (..)

import Task
import Confirmation.Messages exposing (..)
import Confirmation.Models exposing (ConfirmationOrder)
import OrderBreakdown.Commands
import API.Resources.Orders as OrdersAPI
import OrderBreakdown.Commands


fetchBreakdowns : Cmd Msg
fetchBreakdowns =
    Cmd.map OrderBreakdownMsg OrderBreakdown.Commands.fetch

placeOrder : ConfirmationOrder -> Cmd Msg
placeOrder confirmationOrder =
    OrdersAPI.saveTask confirmationOrder
        |> Task.perform PlaceOrderFail PlaceOrderDone
