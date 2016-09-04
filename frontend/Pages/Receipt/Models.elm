module Pages.Receipt.Models exposing (..)

import API.Models exposing (OrderReceipt)


type alias ReceiptPageModel =
    { orderReceipt : OrderReceipt
    }


init : ReceiptPageModel
init =
    ReceiptPageModel (OrderReceipt 0 "")
