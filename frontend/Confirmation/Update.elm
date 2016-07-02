module Confirmation.Update exposing (..)

import Confirmation.Messages exposing (Msg(..))
import Confirmation.Models exposing (ConfirmationOrder)
import CartItems.Update


update : Msg -> ConfirmationOrder -> ( ConfirmationOrder, Cmd Msg )
update action confirmationOrder =
    case action of
        CartItemsMsg subMsg ->
            let
                ( newCartItems, cmds ) =
                    CartItems.Update.update subMsg confirmationOrder.cartItems
            in
                ( { confirmationOrder | cartItems = newCartItems }, Cmd.map CartItemsMsg cmds )

        UpdateEmail newEmail ->
            ( { confirmationOrder | email = newEmail }, Cmd.none )

        UpdatePaymentMethod newPaymentMethod ->
            ( { confirmationOrder | paymentMethod = newPaymentMethod }, Cmd.none )

        UpdatePickupLocation newPickupLocation ->
            ( { confirmationOrder | pickupLocation = newPickupLocation }, Cmd.none )

        FetchBreakdownsDone newOrderBreakdown ->
            ( newOrderBreakdown, Cmd.none )

        FetchBreakdownsFail _ ->
            ( confirmationOrder, Cmd.none )
