module Pages.Confirmation.Models exposing (..)

import API.Models exposing (OrderBreakdown, OrderConfirmation)


type alias ConfirmationPageModel =
    { orderConfirmation : OrderConfirmation
    , orderBreakdown : OrderBreakdown
    }


init : ConfirmationPageModel
init =
    ConfirmationPageModel (OrderConfirmation "" "" "") (OrderBreakdown "" "" [])
