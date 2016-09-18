module Commands exposing (..)

import Task
import Basics.Extra exposing (never)
import Messages exposing (Msg(..))
import Models exposing (State)
import API.Models exposing (ID)
import API.Resources.Orders as OrdersAPI
import API.Resources.Products as ProductsAPI
import API.Resources.Cart as CartAPI
import API.Resources.Breakdowns as BreakdownsAPI


fetchOrder : String -> Cmd Msg
fetchOrder orderUuid =
    OrdersAPI.fetchTask orderUuid
        |> Task.perform FetchOrderFail FetchOrderSucceed


fetchProducts : Maybe String -> Cmd Msg
fetchProducts keyword =
    ProductsAPI.fetchTask keyword
        |> Task.perform FetchProductsFail FetchProductsSuccess


addProductToCart : Int -> Cmd Msg
addProductToCart productId =
    CartAPI.saveTask productId
        |> Task.perform (AddToCartFail productId) (always AddToCartSuccess)


fetchCart : Cmd Msg
fetchCart =
    CartAPI.fetchTask
        |> Task.perform FetchCartFail FetchCartSucceed


resetState : Cmd Msg
resetState =
    (Task.succeed ()) |> Task.perform never (always Reset)


fetchBreakdowns : Cmd Msg
fetchBreakdowns =
    BreakdownsAPI.fetchTask
        |> Task.perform FetchBreakdownsFail FetchBreakdownsSucceed


updateItem : ID -> Int -> Int -> Cmd Msg
updateItem itemId oldQuantity newQuantity =
    CartAPI.updateTask itemId newQuantity
        |> Task.perform (UpdateItemQuantityFail itemId oldQuantity) (always UpdateItemQuantitySucceed)


removeItem : ID -> Cmd Msg
removeItem itemId =
    CartAPI.deleteTask itemId
        |> Task.perform RemoveItemFail (always RemoveItemSucceed)


placeOrder : State -> Cmd Msg
placeOrder { orderConfirmation } =
    OrdersAPI.saveTask orderConfirmation
        |> Task.perform PlaceOrderFail PlaceOrderSucceed
