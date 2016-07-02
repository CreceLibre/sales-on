module OrderBreakdown.Messages exposing (..)

import Http
import OrderBreakdown.Models exposing (OrderBreakdown)
import CartItems.Messages

type Msg
  = FetchBreakdownsDone OrderBreakdown
  | FetchBreakdownsFail Http.Error
  | CartItemsMsg CartItems.Messages.Msg
