module Receipt.Update exposing (..)

import Receipt.Messages exposing (Msg(..))
import Receipt.Models exposing (Order')


update : Msg -> Order' -> ( Order', Cmd Msg )
update msg order =
    case msg of
        FetchOrderDone updatedOrder ->
            ( updatedOrder, Cmd.none )

        FetchOrderFail error ->
            ( order, Cmd.none )
