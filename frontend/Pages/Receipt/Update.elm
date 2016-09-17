module Pages.Receipt.Update exposing (..)

import Pages.Receipt.Messages exposing (Msg(..))
import Pages.Receipt.Models exposing (ReceiptPageModel)


update : Msg -> ReceiptPageModel -> ( ReceiptPageModel, Cmd Msg )
update msg order =
    case msg of
        FetchOrderDone updatedOrder ->
            { order | orderReceipt = updatedOrder }
                ! [ Cmd.none ]

        FetchOrderFail error ->
            order
                ! [ Cmd.none ]
