module OrderBreakdown.Commands exposing (..)

import OrderBreakdown.Messages exposing (..)
import Task
import OrderBreakdown.Models exposing (ItemId)
import API.Resources.Breakdowns as BreakdownsAPI
import API.Resources.Cart as CartAPI

fetch : Cmd Msg
fetch =
    BreakdownsAPI.fetchTask
      |> Task.perform FetchBreakdownsFail FetchBreakdownsDone

updateItem : ItemId -> Int -> Cmd Msg
updateItem itemId newQuantity =
  CartAPI.updateTask itemId newQuantity
      |> Task.perform UpdateItemQuantityFail (always UpdateItemQuantityDone)
