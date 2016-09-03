module Pages.Products.Commands exposing (..)

import API.Models exposing (ProductId, Product)
import Pages.Products.Models exposing (ProductPageModel)
import Pages.Products.Messages exposing (..)
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
        |> Task.perform (AddToCartFail productId) (always AddToCartSuccess)
