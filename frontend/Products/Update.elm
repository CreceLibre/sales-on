module Products.Update exposing (..)

import Products.Messages exposing (Msg(..))
import Products.Models exposing (Product)
import AddToCart.Update


update : Msg -> List Product -> ( List Product, Cmd Msg )
update action products =
    case action of
        FetchAllDone newProducts ->
            ( newProducts, Cmd.none )

        FetchAllFail error ->
            let
                _ =
                    Debug.log "err" error
            in
                ( products, Cmd.none )

        AddToCartMsg productId subMsg ->
            let
                updateCartButton product =
                    if product.id == productId then
                        let
                            ( updatedAddToCart, cmds ) =
                                AddToCart.Update.update subMsg product.addToCart
                        in
                            ( { product | addToCart = updatedAddToCart }, Cmd.map (AddToCartMsg productId) cmds )
                    else
                        ( product, Cmd.none )

                ( products', cmds' ) =
                    List.map updateCartButton products
                      |> List.unzip
            in
                ( products', Cmd.batch cmds' )
