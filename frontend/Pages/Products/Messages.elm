module Pages.Products.Messages exposing (..)

import Http
import API.Models exposing (Product)


type Msg
    = FetchAllDone (List Product)
    | FetchAllFail Http.Error
    | AddToCart Int
    | AddToCartSuccess
    | AddToCartFail Int Http.Error
    | UpdateSearch String
    | ClickOnSearch
