module Pages.Products.Commands exposing (..)

import Pages.Products.Messages exposing (..)
import Task
import API.Resources.Products as ProductsAPI
import API.Resources.Cart as CartAPI


fetchProducts : Maybe String -> Cmd Msg
fetchProducts keyword =
    let
        isFullFetch =
            case keyword of
                Just _ ->
                    False

                Nothing ->
                    True
    in
        ProductsAPI.fetchTask keyword
            |> Task.perform FetchProductsFail (FetchProductsSuccess isFullFetch)


addProductToCart : Int -> Cmd Msg
addProductToCart productId =
    CartAPI.saveTask productId
        |> Task.perform (AddToCartFail productId) (always AddToCartSuccess)
