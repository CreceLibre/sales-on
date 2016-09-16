module API.Models exposing (..)


type alias ID =
    Int


type alias Product =
    { id : Int
    , name : String
    , category : String
    , price : String
    , isInCart : Bool
    }


type alias Item =
    { id : Int
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


type alias OrderConfirmation =
    { email : String
    , paymentMethod : String
    , pickupLocation : String
    }


type alias OrderReceipt =
    { id : Int
    , email : String
    }
