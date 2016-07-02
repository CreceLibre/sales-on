module Confirmation.Models exposing (..)

import CartItems.Models exposing (CartItem)
import Shared.Models exposing (Amount, initAmount)

type alias ConfirmationOrder =
    { email : String
    , paymentMethod : String
    , pickupLocation : String
    , subtotal: Amount
    , total: Amount
    , cartItems : (List CartItem)
    }

init : ConfirmationOrder
init =
  ConfirmationOrder "" "" "" initAmount initAmount []
