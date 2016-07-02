module Confirmation.Update exposing (..)

import Confirmation.Messages exposing (Msg(..))
import Confirmation.Models exposing (ConfirmationOrder)
import OrderBreakdown.Update


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
