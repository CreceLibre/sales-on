module Receipt.Models exposing (..)


type alias Order' =
    { id : Int
    , email : String
    }


init : Order'
init =
    Order' 0 ""
