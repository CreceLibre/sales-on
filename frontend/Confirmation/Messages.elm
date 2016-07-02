module Confirmation.Messages exposing (..)

import OrderBreakdown.Messages

type Msg
  = UpdateEmail String
  | UpdatePaymentMethod String
  | UpdatePickupLocation String
  | OrderBreakdownMsg OrderBreakdown.Messages.Msg
