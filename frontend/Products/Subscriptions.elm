module Products.Subscriptions exposing (..)

import Products.Messages exposing (Msg(..))
import Products.Models exposing (Product)
import Ports exposing (..)


subscriptions : List Product -> Sub Msg
subscriptions products =
    fetchProductsSub FetchByTerm
