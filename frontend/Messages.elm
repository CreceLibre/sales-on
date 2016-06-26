module Messages exposing (..)

import Products.Messages
import SearchProduct.Messages

type Msg
  = ProductsMsg Products.Messages.Msg
  | SearchProductMsg SearchProduct.Messages.Msg
