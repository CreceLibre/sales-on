module Confirmation.Models exposing (..)


type alias ConfirmationOrder =
    { email : String
    , paymentMethod : String
    , pickupLocation : String
    }

init : ConfirmationOrder
init =
  ConfirmationOrder "" "" ""
