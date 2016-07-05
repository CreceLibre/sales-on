module CartItems.Update exposing (..)

import CartItems.Messages exposing (Msg(..))
import CartItems.Models exposing (CartItemId, CartItem)
import CartItems.Commands exposing (updateCartItem)


updateQuantityCmd : CartItemId -> Int -> List CartItem -> List (Cmd Msg)
updateQuantityCmd cartItemId howMuch cartItems =
    let
        update cartItem =
            if cartItem.id == cartItemId then
                if howMuch < 0 && cartItem.quantity <= 1 then
                    Cmd.none
                else
                    updateCartItem cartItemId (cartItem.quantity + howMuch)
            else
                Cmd.none
    in
        List.map update cartItems


updateQuantity : CartItemId -> Int -> List CartItem -> List CartItem
updateQuantity cartItemId newQuantity cartItems =
    let
        update cartItem =
            if cartItem.id == cartItemId then
                { cartItem | quantity = newQuantity }
            else
                cartItem
    in
        List.map update cartItems


update : Msg -> List CartItem -> ( List CartItem, Cmd Msg )
update msg cartItems =
    case msg of
        IncreaseQuantity cartItemId ->
            ( cartItems, updateQuantityCmd cartItemId 1 cartItems |> Cmd.batch )

        DecreaseQuantity cartItemId ->
            ( cartItems, updateQuantityCmd cartItemId -1 cartItems |> Cmd.batch )

        UpdateCartItemQuantityDone ( cartItemId, newQuantity ) ->
            ( updateQuantity cartItemId newQuantity cartItems, Cmd.none )

        UpdateCartItemQuantityFail _ ->
            ( cartItems, Cmd.none )
