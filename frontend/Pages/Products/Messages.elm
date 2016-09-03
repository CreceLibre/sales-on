module Pages.Products.Messages exposing (..)

import Http
import API.Models exposing (ProductId, Product)


type Msg
    = FetchAllDone (List Product)
    | FetchAllFail Http.Error
    | AddToCart ProductId
    | AddToCartSuccess
    | AddToCartFail ProductId Http.Error
    | UpdateSearch String
    | ClickOnSearch
