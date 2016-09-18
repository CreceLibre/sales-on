module Pages.Products.Messages exposing (..)

import Http
import API.Models exposing (Product)
import Utils exposing (GlobalEvent)


type Msg
    = FetchProductsSuccess Bool (List Product)
    | FetchProductsFail Http.Error
    | AddToCart Int
    | AddToCartSuccess
    | AddToCartFail Int Http.Error
    | GlobalEvent GlobalEvent
