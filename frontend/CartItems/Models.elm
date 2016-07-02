module CartItems.Models exposing (..)

type alias CartItemId =
    Int


type alias CartItem =
    { id : CartItemId
    , name : String
    , unitPrice : String
    , total : String
    , quantity : Int
    }
