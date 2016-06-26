module SearchProduct.Update exposing (..)

import SearchProduct.Messages exposing (Msg(..), OutMsg(..))
import SearchProduct.Models exposing (SearchProduct)


update : Msg -> SearchProduct -> ( SearchProduct, Cmd Msg, OutMsg )
update action searchProduct =
    case action of
        UpdateSearch keyword ->
          if keyword == "" then
            ( Nothing, Cmd.none, NoOp )
          else
            ( Just keyword, Cmd.none, NoOp )

        Click ->
            ( searchProduct, Cmd.none, Search )
