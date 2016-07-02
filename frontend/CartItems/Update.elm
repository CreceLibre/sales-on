module CartItems.Update exposing (..)

import CartItems.Messages exposing (Msg(..))
import CartItems.Models exposing (CartItem)


update : Msg -> List CartItem -> ( List CartItem, Cmd Msg )
update action cartItems =
    case action of
        IncreaseQuantity ->
            ( cartItems, Cmd.none )

        DecreaseQuantity ->
            ( cartItems, Cmd.none )

        UpdateCartItem _ ->
            ( cartItems, Cmd.none )

        UpdateCartItemFail _ ->
            ( cartItems, Cmd.none )
