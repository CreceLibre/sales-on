module Pages.Products.Update exposing (..)

import Pages.Products.Messages exposing (Msg(..))
import Pages.Products.Models exposing (ProductPageModel, IndexedProduct)
import Pages.Products.Commands exposing (addProductToCart, fetchProducts)
import Utils exposing (GlobalEvent(..))


update : Msg -> ProductPageModel -> ( ProductPageModel, Cmd Msg, Maybe GlobalEvent )
update action model =
    case action of
        FetchProductsSuccess wasFullFetch response ->
            let
                newProducts =
                    (List.indexedMap (\i p -> ( i + 1, p )) response)

                globalEvent =
                    if wasFullFetch then
                        Just FetchAllProducts
                    else
                        Nothing
            in
                ( { model
                    | products = newProducts
                    , isLoading = False
                  }
                , Cmd.none
                , globalEvent
                )

        FetchProductsFail error ->
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
            ( model, Cmd.none, Just NewCartWasAdded )

        AddToCartFail productId error ->
            let
                newProducts =
                    List.map (updateCartStatus productId False) model.products
            in
                ( { model | products = newProducts }
                , Cmd.none
                , Nothing
                )

        GlobalEvent e ->
            case e of
                SearchForProduct keyword ->
                    ( { model | isLoading = True }, fetchProducts keyword, Nothing )

                _ ->
                    ( model, Cmd.none, Nothing )


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
