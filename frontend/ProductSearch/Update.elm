module ProductSearch.Update exposing (..)

import Ports exposing (fetchProductsCmd)
import ProductSearch.Messages exposing (Msg(..), OutMsg(..))
import ProductSearch.Models exposing (ProductSearch)


update : Msg -> ProductSearch -> ( ProductSearch, Cmd Msg )
update action productSearch =
    case action of
        UpdateSearch keyword ->
          if keyword == "" then
            ( Nothing, Cmd.none )
          else
            ( Just keyword, Cmd.none )

        Click ->
          ( productSearch, fetchProductsCmd productSearch )
