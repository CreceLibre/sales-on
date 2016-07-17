module Pages.Receipt.Update exposing (..)

import Pages.Receipt.Messages exposing (Msg(..))
import Pages.Receipt.Models exposing (Order')


update : Msg -> Order' -> ( Order', Cmd Msg )
update msg order =
    case msg of
        FetchOrderDone updatedOrder ->
            ( updatedOrder, Cmd.none )

        FetchOrderFail error ->
            ( order, Cmd.none )
