module Receipt.Messages exposing (..)

import Http
import Receipt.Models exposing (Order')


type Msg
  = FetchOrderDone Order'
  | FetchOrderFail Http.Error
