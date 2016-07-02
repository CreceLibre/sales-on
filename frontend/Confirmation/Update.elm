module Confirmation.Update exposing (..)

import Confirmation.Messages exposing (Msg(..))
import Confirmation.Models exposing (ConfirmationOrder)


update : Msg -> ConfirmationOrder -> ( ConfirmationOrder, Cmd Msg )
update action confirmationOrder =
    case action of
        UpdateEmail newEmail ->
            ( { confirmationOrder | email = newEmail }, Cmd.none )

        UpdatePaymentMethod newPaymentMethod ->
            ( { confirmationOrder | paymentMethod = newPaymentMethod }, Cmd.none )

        UpdatePickupLocation newPickupLocation ->
            ( { confirmationOrder | pickupLocation = newPickupLocation }, Cmd.none )
