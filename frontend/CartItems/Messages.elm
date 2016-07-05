module CartItems.Messages exposing (..)

import Http
import CartItems.Models exposing (CartItemId, CartItem)

type Msg
  = IncreaseQuantity CartItemId
  | DecreaseQuantity CartItemId
  | UpdateCartItemQuantityDone (CartItemId, Int)
  | UpdateCartItemQuantityFail Http.Error
