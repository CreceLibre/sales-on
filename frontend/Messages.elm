module Messages exposing (..)

import Products.Messages
import ProductSearch.Messages
import Confirmation.Messages
import Receipt.Messages

type Msg
  = ProductsMsg Products.Messages.Msg
  | ProductSearchMsg ProductSearch.Messages.Msg
  | ConfirmationMsg Confirmation.Messages.Msg
  | ReceiptMsg Receipt.Messages.Msg
  | ShowConfirmation
