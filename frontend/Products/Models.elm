module Products.Models exposing (..)

import AddToCart.Models exposing (..)

type alias ProductId =
    Int


type alias Product =
    { id : ProductId
    , name : String
    , category : String
    , price : Int
    , addToCart : AddToCart
    }
