module API.Models exposing (..)


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


type alias Product =
    { id : Int
    , name : String
    , category : String
    , price : String
    , isInCart : Bool
    }


type alias OrderReceipt =
    { id : Int
    , email : String
    }
