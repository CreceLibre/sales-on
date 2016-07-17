module Pages.Confirmation.Update exposing (..)

import Pages.Confirmation.Messages exposing (Msg(..))
import Pages.Confirmation.Models exposing (ConfirmationOrder)
import Pages.Confirmation.Commands exposing (placeOrder)
import OrderBreakdown.Update
import Navigation


update : Msg -> ConfirmationOrder -> ( ConfirmationOrder, Cmd Msg )
update msg confirmationOrder =
    case msg of
        OrderBreakdownMsg subMsg ->
            let
                ( newOrderBreakdown, cmds ) =
                    OrderBreakdown.Update.update subMsg confirmationOrder.orderBreakdown
            in
                ( { confirmationOrder | orderBreakdown = newOrderBreakdown }, Cmd.map OrderBreakdownMsg cmds )

        UpdateEmail newEmail ->
            ( { confirmationOrder | email = newEmail }, Cmd.none )

        UpdatePaymentMethod newPaymentMethod ->
            ( { confirmationOrder | paymentMethod = newPaymentMethod }, Cmd.none )

        UpdatePickupLocation newPickupLocation ->
            ( { confirmationOrder | pickupLocation = newPickupLocation }, Cmd.none )

        PlaceOrderDone orderUuid ->
          ( confirmationOrder, Navigation.newUrl ("#receipt/" ++ orderUuid) )

        PlaceOrderFail error ->
            ( confirmationOrder, Cmd.none )

        PlaceOrder ->
            ( confirmationOrder, placeOrder confirmationOrder )
