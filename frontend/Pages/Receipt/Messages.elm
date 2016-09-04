module Pages.Receipt.Messages exposing (..)

import Http
import API.Models exposing (OrderReceipt)


type Msg
    = FetchOrderDone OrderReceipt
    | FetchOrderFail Http.Error
