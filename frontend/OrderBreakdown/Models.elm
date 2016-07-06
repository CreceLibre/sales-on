module OrderBreakdown.Models exposing (..)

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


init : OrderBreakdown
init =
    OrderBreakdown "" "" []
