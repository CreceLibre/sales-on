module Pages.Confirmation.Models exposing (..)


type alias ItemId =
    Int


type alias Item =
    { id : ItemId
    , name : String
    , unitPrice : String
    , total : String
    , quantity : Int
    }


type alias OrderBreakdown =
    { subtotal : String
    , total : String
    , items : List Item
    }


type alias ConfirmationOrder =
    { email : String
    , paymentMethod : String
    , pickupLocation : String
    , orderBreakdown : OrderBreakdown
    }


init : ConfirmationOrder
init =
    ConfirmationOrder "andres@otarola.me" "webpay" "galpon" (OrderBreakdown "" "" [])
