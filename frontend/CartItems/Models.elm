module CartItems.Models exposing (..)

import Shared.Models exposing (Amount)

type alias CartItemId =
    Int


type alias CartItem =
    { id : CartItemId
    , name : String
    , unitPrice : Amount
    , total : Amount
    , quantity : Int
    }
