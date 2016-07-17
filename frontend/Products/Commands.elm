module Products.Commands exposing (..)

import Products.Models exposing (ProductId, Product, ProductPageModel)
import Products.Messages exposing (..)
import Task
import API.Resources.Products as ProductsAPI
import API.Resources.Cart as CartAPI

fetch : ProductPageModel -> Cmd Msg
fetch model =
    ProductsAPI.fetchTask model.search
        |> Task.perform FetchAllFail FetchAllDone


addProductToCart : ProductId -> Cmd Msg
addProductToCart productId =
    CartAPI.saveTask productId
        |> Task.perform AddToCartFail (always AddToCartSuccess)
