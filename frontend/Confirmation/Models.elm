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
  ConfirmationOrder "" "" "" OrderBreakdown.Models.init
