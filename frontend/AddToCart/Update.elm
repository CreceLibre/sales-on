module AddToCart.Update exposing (..)

import AddToCart.Messages exposing (Msg(..))
import AddToCart.Models exposing (AddToCart)


update : Msg -> AddToCart -> ( AddToCart, Cmd Msg)
update action searchProduct =
    case action of
        Add ->
            ( searchProduct, Cmd.none)
