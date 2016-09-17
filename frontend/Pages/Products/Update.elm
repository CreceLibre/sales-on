module Pages.Products.Update exposing (..)

import Pages.Products.Messages exposing (Msg(..))
import Pages.Products.Models exposing (ProductPageModel, IndexedProduct)
import Pages.Products.Commands exposing (addProductToCart, fetchProducts)


type OutMsg
    = NewCartItem


update : Msg -> ProductPageModel -> ( ProductPageModel, Cmd Msg, Maybe OutMsg )
update action model =
    case action of
        FetchAllDone response ->
            let
                newProducts =
                    (List.indexedMap (\i p -> ( i + 1, p )) response)
            in
                ( { model
                    | products = newProducts
                    , isLoading = False
                  }
                , Cmd.none
                , Nothing
                )

        FetchAllFail error ->
            ( { model | isLoading = False }, Cmd.none, Nothing )

        AddToCart productId ->
            let
                newProducts =
                    List.map (updateCartStatus productId True) model.products
            in
                ( { model | products = newProducts }
                , addToCartCommands productId model.products |> Cmd.batch
                , Nothing
                )

        AddToCartSuccess ->
            ( model, Cmd.none, Just NewCartItem )

        AddToCartFail productId error ->
            let
                newProducts =
                    List.map (updateCartStatus productId False) model.products
            in
                ( { model | products = newProducts }
                , Cmd.none
                , Nothing
                )

        UpdateSearch keyword ->
            let
                search =
                    if keyword == "" then
                        Nothing
                    else
                        Just keyword
            in
                ( { model | search = search }, Cmd.none, Nothing )

        ClickOnSearch ->
            ( { model | isLoading = True }, fetchProducts model, Nothing )


updateCartStatus : Int -> Bool -> IndexedProduct -> IndexedProduct
updateCartStatus productId status indexedProduct =
    let
        ( index, product ) =
            indexedProduct
    in
        if product.id == productId then
            ( index, { product | isInCart = status } )
        else
            ( index, product )


addToCartCommands : Int -> List IndexedProduct -> List (Cmd Msg)
addToCartCommands productId =
    let
        cmdForProduct ( index, product ) =
            if product.id == productId then
                addProductToCart productId
            else
                Cmd.none
    in
        List.map cmdForProduct
