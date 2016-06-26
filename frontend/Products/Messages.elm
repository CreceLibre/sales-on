module Products.Messages exposing (..)

import Http
import Products.Models exposing (ProductId, Product)
import AddToCart.Messages

type Msg
  = FetchAllDone (List Product)
  | FetchAllFail Http.Error
  | AddToCartMsg ProductId AddToCart.Messages.Msg
