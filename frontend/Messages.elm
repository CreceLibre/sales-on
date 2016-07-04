module Messages exposing (..)

import Products.Messages
import SearchProduct.Messages
import Confirmation.Messages
import Receipt.Messages

type Msg
  = ProductsMsg Products.Messages.Msg
  | SearchProductMsg SearchProduct.Messages.Msg
  | ConfirmationMsg Confirmation.Messages.Msg
  | ReceiptMsg Receipt.Messages.Msg
  | ShowConfirmation
