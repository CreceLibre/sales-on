module CartItems.Messages exposing (..)

import Http
import CartItems.Models exposing (CartItemId, CartItem)

type Msg
  = IncreaseQuantity
  | DecreaseQuantity
  | UpdateCartItem CartItem
  | UpdateCartItemFail Http.Error
