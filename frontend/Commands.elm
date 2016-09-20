module Commands exposing (..)

import Task
import Basics.Extra exposing (never)
import Messages exposing (Msg(..))
import State exposing (State)
import API.Models exposing (ID)
import API.Resources.Orders as OrdersAPI
import API.Resources.Products as ProductsAPI
import API.Resources.Cart as CartAPI
import API.Resources.Breakdowns as BreakdownsAPI
import Encoders
    exposing
        ( saveCartItemEncoder
        , deleteCartItemEncoder
        , updateItemEncoder
        , saveOrderEncoder
        )
import Decoders
    exposing
        ( breakdownsCollectionDecoder
        , cartItemCollectionDecoder
        , orderReceiptDecoder
        , productCollectionDecoder
        )


placeOrder : State -> Cmd Msg
placeOrder { orderConfirmation } =
    OrdersAPI.saveTask (saveOrderEncoder orderConfirmation) orderReceiptDecoder
        |> Task.perform PlaceOrderFail PlaceOrderSucceed


fetchOrder : String -> Cmd Msg
fetchOrder orderUuid =
    OrdersAPI.fetchTask orderUuid orderReceiptDecoder
        |> Task.perform FetchOrderFail FetchOrderSucceed


fetchProducts : Maybe String -> Cmd Msg
fetchProducts keyword =
    ProductsAPI.fetchTask keyword productCollectionDecoder
        |> Task.perform FetchProductsFail FetchProductsSuccess


addProductToCart : Int -> Cmd Msg
addProductToCart productId =
    CartAPI.saveTask (saveCartItemEncoder productId)
        |> Task.perform (AddToCartFail productId) (always AddToCartSuccess)


fetchCart : Cmd Msg
fetchCart =
    CartAPI.fetchTask cartItemCollectionDecoder
        |> Task.perform FetchCartFail FetchCartSucceed


resetConfirmationState : Cmd Msg
resetConfirmationState =
    (Task.succeed ()) |> Task.perform never (always ResetConfirmation)


resetSearchState : Cmd Msg
resetSearchState =
    (Task.succeed ()) |> Task.perform never (always ResetSearch)


fetchBreakdowns : Cmd Msg
fetchBreakdowns =
    BreakdownsAPI.fetchTask breakdownsCollectionDecoder
        |> Task.perform FetchBreakdownsFail FetchBreakdownsSucceed


updateItem : ID -> Int -> Int -> Cmd Msg
updateItem itemId oldQuantity newQuantity =
    CartAPI.updateTask (updateItemEncoder itemId newQuantity)
        |> Task.perform (UpdateItemQuantityFail itemId oldQuantity) (always UpdateItemQuantitySucceed)


removeItem : ID -> Cmd Msg
removeItem itemId =
    CartAPI.deleteTask (deleteCartItemEncoder itemId)
        |> Task.perform RemoveItemFail (always RemoveItemSucceed)
