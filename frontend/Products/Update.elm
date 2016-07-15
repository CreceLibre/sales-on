module Products.Update exposing (..)

import Products.Messages exposing (Msg(..))
import Products.Models exposing (Product, ProductId)
import Products.Commands exposing (addProductToCart, fetch)


update : Msg -> List Product -> ( List Product, Cmd Msg )
update action products =
    case action of
        FetchAllDone newProducts ->
            ( newProducts, Cmd.none )

        FetchAllFail error ->
            ( products, Cmd.none )

        AddToCart productId ->
            ( products, addToCartCommands productId products |> Cmd.batch )

        AddToCartSuccess ->
            ( products, Cmd.none )

        AddToCartFail error ->
            ( products, Cmd.none )

        FetchByTerm term ->
            ( products, fetch term )


addToCartCommands : ProductId -> List Product -> List (Cmd Msg)
addToCartCommands productId =
    let
        cmdForProduct product =
            if product.id == productId then
                addProductToCart productId
            else
                Cmd.none
    in
        List.map cmdForProduct
