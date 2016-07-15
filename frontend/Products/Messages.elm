module Products.Messages exposing (..)

import Http
import Products.Models exposing (ProductId, Product)


type Msg
    = FetchAllDone (List Product)
    | FetchAllFail Http.Error
    | AddToCart ProductId
    | AddToCartSuccess
    | AddToCartFail Http.Error
    | FetchByTerm (Maybe String)
