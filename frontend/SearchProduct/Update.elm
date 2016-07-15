module SearchProduct.Update exposing (..)

import Ports exposing (fetchProductsCmd)
import SearchProduct.Messages exposing (Msg(..), OutMsg(..))
import SearchProduct.Models exposing (SearchProduct)


update : Msg -> SearchProduct -> ( SearchProduct, Cmd Msg )
update action searchProduct =
    case action of
        UpdateSearch keyword ->
          if keyword == "" then
            ( Nothing, Cmd.none )
          else
            ( Just keyword, Cmd.none )

        Click ->
          ( searchProduct, fetchProductsCmd searchProduct )
