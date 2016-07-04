module Confirmation.Messages exposing (..)

import Http
import OrderBreakdown.Messages


type Msg
    = UpdateEmail String
    | UpdatePaymentMethod String
    | UpdatePickupLocation String
    | OrderBreakdownMsg OrderBreakdown.Messages.Msg
    | PlaceOrderDone String
    | PlaceOrderFail Http.Error
    | PlaceOrder
