module OrderBreakdown.Models exposing (..)

import CartItems.Models exposing (CartItem)


type alias OrderBreakdown =
    { subtotal : String
    , total : String
    , cartItems : List CartItem
    }


init : OrderBreakdown
init =
    OrderBreakdown "" "" []
