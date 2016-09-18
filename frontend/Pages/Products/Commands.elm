module Pages.Products.Commands exposing (..)

import Pages.Products.Messages exposing (..)
import Task
import API.Resources.Products as ProductsAPI
import API.Resources.Cart as CartAPI


fetchProducts : Maybe String -> Cmd Msg
fetchProducts keyword =
    ProductsAPI.fetchTask keyword
        |> Task.perform FetchAllFail FetchAllDone


addProductToCart : Int -> Cmd Msg
addProductToCart productId =
    CartAPI.saveTask productId
        |> Task.perform (AddToCartFail productId) (always AddToCartSuccess)
