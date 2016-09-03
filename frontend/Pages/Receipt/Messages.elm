module Pages.Receipt.Messages exposing (..)

import Http
import Pages.Receipt.Models exposing (Order')


type Msg
    = FetchOrderDone Order'
    | FetchOrderFail Http.Error
