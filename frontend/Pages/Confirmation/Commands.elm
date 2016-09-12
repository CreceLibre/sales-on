module Pages.Confirmation.Commands exposing (..)

import Task
import Pages.Confirmation.Messages exposing (..)
import Pages.Confirmation.Models exposing (ConfirmationPageModel)
import API.Resources.Orders as OrdersAPI
import API.Resources.Breakdowns as BreakdownsAPI
import API.Resources.Cart as CartAPI


fetchBreakdowns : Cmd Msg
fetchBreakdowns =
    BreakdownsAPI.fetchTask
        |> Task.perform FetchBreakdownsFail FetchBreakdownsDone


updateItem : Int -> Int -> Int -> Cmd Msg
updateItem itemId oldQuantity newQuantity =
    CartAPI.updateTask itemId newQuantity
        |> Task.perform (UpdateItemQuantityFail itemId oldQuantity) (always UpdateItemQuantityDone)


placeOrder : ConfirmationPageModel -> Cmd Msg
placeOrder { orderConfirmation } =
    OrdersAPI.saveTask orderConfirmation
        |> Task.perform PlaceOrderFail PlaceOrderDone
