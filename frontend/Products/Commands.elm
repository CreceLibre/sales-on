module Products.Commands exposing (..)

import Products.Models exposing (ProductId, Product)
import Products.Messages exposing (..)
import Task
import API.Resources.Products as ProductsAPI
import API.Resources.Cart as CartAPI

fetch : Maybe String -> Cmd Msg
fetch query =
    ProductsAPI.fetchTask query
        |> Task.perform FetchAllFail FetchAllDone


addProductToCart : ProductId -> Cmd Msg
addProductToCart productId =
    CartAPI.saveTask productId
        |> Task.perform AddToCartFail (always AddToCartSuccess)
