module Pages.Confirmation.Commands exposing (..)

import Task
import Pages.Confirmation.Messages exposing (..)
import Pages.Confirmation.Models exposing (ConfirmationOrder)
import API.Resources.Orders as OrdersAPI
import API.Resources.Breakdowns as BreakdownsAPI
import API.Resources.Cart as CartAPI


fetchBreakdowns : Cmd Msg
fetchBreakdowns =
    BreakdownsAPI.fetchTask
        |> Task.perform FetchBreakdownsFail FetchBreakdownsDone


updateItem : Int -> Int -> Cmd Msg
updateItem itemId newQuantity =
    CartAPI.updateTask itemId newQuantity
        |> Task.perform UpdateItemQuantityFail (always UpdateItemQuantityDone)


placeOrder : ConfirmationOrder -> Cmd Msg
placeOrder confirmationOrder =
    OrdersAPI.saveTask confirmationOrder
        |> Task.perform PlaceOrderFail PlaceOrderDone
