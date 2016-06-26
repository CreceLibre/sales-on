module AddToCart.Update exposing (..)

import AddToCart.Messages exposing (Msg(..))
import AddToCart.Models exposing (AddToCart)


update : Msg -> AddToCart -> ( AddToCart, Cmd Msg)
update action addToCart =
    case action of
        Add ->
            ( addToCart, Cmd.none)
