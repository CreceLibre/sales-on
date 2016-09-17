module API.Models exposing (..)


type alias ID =
    Int


type alias Product =
    { id : ID
    , name : String
    , category : String
    , price : String
    , isInCart : Bool
    }


type alias CartItem =
    { id : ID
    , quantity : Int
    }


type alias OrderBreakdownItem =
    { id : ID
    , name : String
    , unitPrice : String
    , total : String
    , quantity : Int
    }


type alias OrderBreakdown =
    { subtotal : String
    , total : String
    , items : List OrderBreakdownItem
    }


type alias OrderConfirmation =
    { email : String
    , paymentMethod : String
    , pickupLocation : String
    }


type alias OrderReceipt =
    { id : ID
    , email : String
    }
