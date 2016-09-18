module Pages.Receipt.Messages exposing (..)

import Http
import API.Models exposing (OrderReceipt)


type Msg
    = FetchOrderSucceed OrderReceipt
    | FetchOrderFail Http.Error
