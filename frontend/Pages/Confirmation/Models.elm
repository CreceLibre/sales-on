module Pages.Confirmation.Models exposing (..)

import API.Models exposing (OrderBreakdown, OrderConfirmation)


type alias ConfirmationOrder =
    { orderConfirmation : OrderConfirmation
    , orderBreakdown : OrderBreakdown
    }


init : ConfirmationOrder
init =
    ConfirmationOrder (OrderConfirmation "" "" "") (OrderBreakdown "" "" [])
