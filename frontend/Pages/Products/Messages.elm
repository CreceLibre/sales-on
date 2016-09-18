module Pages.Products.Messages exposing (..)

import Http
import API.Models exposing (Product)
import Utils exposing (GlobalEvent)


type Msg
    = FetchAllDone (List Product)
    | FetchAllFail Http.Error
    | AddToCart Int
    | AddToCartSuccess
    | AddToCartFail Int Http.Error
    | GlobalEvent GlobalEvent
