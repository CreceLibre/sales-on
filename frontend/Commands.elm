module Commands exposing (..)

import Messages exposing (Msg(..))
import Task
import API.Resources.Orders as OrdersAPI
import API.Resources.Products as ProductsAPI
import API.Resources.Cart as CartAPI


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
