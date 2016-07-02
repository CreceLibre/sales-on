module Messages exposing (..)

import Products.Messages
import SearchProduct.Messages
import Confirmation.Messages

type Msg
  = ProductsMsg Products.Messages.Msg
  | SearchProductMsg SearchProduct.Messages.Msg
  | ConfirmationMsg Confirmation.Messages.Msg
  | ShowConfirmation
