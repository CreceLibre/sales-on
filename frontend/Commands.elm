module Commands exposing (..)

import Models exposing (..)
import Messages exposing (..)
import Task
import API.Resources.Products as ProductsAPI
import API.Resources.Cart as CartAPI
import API.Resources.Orders as OrdersAPI
import API.Resources.Breakdowns as BreakdownsAPI


updateItem : ItemId -> Int -> Cmd Msg
updateItem itemId newQuantity =
    CartAPI.updateTask itemId newQuantity
        |> Task.perform UpdateItemQuantityFail (always UpdateItemQuantityDone)


fetchBreakdowns : Cmd Msg
fetchBreakdowns =
    BreakdownsAPI.fetchTask
        |> Task.perform FetchBreakdownsFail FetchBreakdownsDone


placeOrder : ConfirmationOrder -> Cmd Msg
placeOrder confirmationOrder =
    OrdersAPI.saveTask confirmationOrder
        |> Task.perform PlaceOrderFail PlaceOrderDone


fetchProducts : Maybe String -> Cmd Msg
fetchProducts query =
    ProductsAPI.fetchTask query
        |> Task.perform FetchAllProductsFail FetchAllProductsDone


fetchOrder : String -> Cmd Msg
fetchOrder orderUuid =
    OrdersAPI.fetchTask orderUuid
        |> Task.perform FetchOrderFail FetchOrderDone


addProductToCart : ProductId -> Cmd Msg
addProductToCart productId =
    CartAPI.saveTask productId
        |> Task.perform AddToCartFail (always AddToCartSuccess)
