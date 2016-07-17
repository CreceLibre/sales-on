module Pages.Products.Update exposing (..)

import Pages.Products.Messages exposing (Msg(..))
import Pages.Products.Models exposing (Product, ProductId, ProductPageModel, IndexedProduct)
import Pages.Products.Commands exposing (addProductToCart, fetch)


update : Msg -> ProductPageModel -> ( ProductPageModel, Cmd Msg )
update action model =
    case action of
        FetchAllDone newProducts ->
            ( { model
                | products = (List.indexedMap (\i p -> ( i + 1, p )) newProducts)
                , isLoading = False
              }
            , Cmd.none
            )

        FetchAllFail error ->
            ( { model | isLoading = False }, Cmd.none )

        AddToCart productId ->
            ( model, addToCartCommands productId model.products |> Cmd.batch )

        AddToCartSuccess ->
            ( model, Cmd.none )

        AddToCartFail error ->
            ( model, Cmd.none )

        UpdateSearch keyword ->
            let
                search =
                    if keyword == "" then
                        Nothing
                    else
                        Just keyword
            in
                ( { model | search = search }, Cmd.none )

        ClickOnSearch ->
            ( { model | isLoading = True }, fetch model )


addToCartCommands : ProductId -> List IndexedProduct -> List (Cmd Msg)
addToCartCommands productId =
    let
        cmdForProduct ( index, product ) =
            if product.id == productId then
                addProductToCart productId
            else
                Cmd.none
    in
        List.map cmdForProduct
