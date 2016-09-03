module Pages.Confirmation.Models exposing (..)

import API.Models exposing (OrderBreakdown)


type alias ConfirmationOrder =
    { email : String
    , paymentMethod : String
    , pickupLocation : String
    , orderBreakdown : OrderBreakdown
    }


init : ConfirmationOrder
init =
    ConfirmationOrder "andres@otarola.me" "webpay" "galpon" (OrderBreakdown "" "" [])
