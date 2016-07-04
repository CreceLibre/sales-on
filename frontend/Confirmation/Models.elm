module Confirmation.Models exposing (..)

import OrderBreakdown.Models exposing (OrderBreakdown)

type alias ConfirmationOrder =
    { email : String
    , paymentMethod : String
    , pickupLocation : String
    , orderBreakdown : OrderBreakdown
    }

init : ConfirmationOrder
init =
  ConfirmationOrder "andres@otarola.me" "webpay" "galpon" OrderBreakdown.Models.init
