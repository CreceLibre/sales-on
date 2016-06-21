module Products.Update exposing (..)

import Products.Messages exposing (Msg(..))
import Products.Models exposing (Product)


update : Msg -> List Product -> ( List Product, Cmd Msg )
update action products =
    case action of
        FetchAllDone newProducts ->
            ( newProducts, Cmd.none )

        FetchAllFail error ->
            ( products, Cmd.none )
