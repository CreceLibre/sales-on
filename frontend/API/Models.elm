module API.Models exposing (..)


type alias ItemId =
    Int


type alias ProductId =
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


type alias Product =
    { id : ProductId
    , name : String
    , category : String
    , price : String
    , isInCart : Bool
    }


type alias Order' =
    { id : Int
    , email : String
    }
