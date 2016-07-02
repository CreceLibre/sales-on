module OrderBreakdown.Update exposing (..)

import OrderBreakdown.Messages exposing (Msg(..))
import OrderBreakdown.Models exposing (OrderBreakdown)
import CartItems.Update


update : Msg -> OrderBreakdown -> ( OrderBreakdown, Cmd Msg )
update msg orderBreakdown =
    case msg of
        CartItemsMsg subMsg ->
            let
                ( newCartItems, cmds ) =
                    CartItems.Update.update subMsg orderBreakdown.cartItems
            in
                ( { orderBreakdown | cartItems = newCartItems }, Cmd.map CartItemsMsg cmds )

        FetchBreakdownsDone newOrderBreakdown ->
            ( newOrderBreakdown, Cmd.none )

        FetchBreakdownsFail _ ->
            ( orderBreakdown, Cmd.none )
