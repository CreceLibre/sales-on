module Confirmation.Messages exposing (..)

import Http
import Confirmation.Models exposing (ConfirmationOrder)
import CartItems.Messages

type Msg
  = UpdateEmail String
  | UpdatePaymentMethod String
  | UpdatePickupLocation String
  | FetchBreakdownsDone ConfirmationOrder
  | FetchBreakdownsFail Http.Error
  | CartItemsMsg CartItems.Messages.Msg
