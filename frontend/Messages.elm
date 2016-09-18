module Messages exposing (..)

import Http
import Pages.Confirmation.Messages
import API.Models exposing (OrderReceipt, Product, ID, CartItem)


type Msg
    = FetchProductsSuccess (List Product)
    | FetchProductsFail Http.Error
    | AddToCart ID
    | AddToCartSuccess
    | AddToCartFail ID Http.Error
    | ConfirmationMsg Pages.Confirmation.Messages.Msg
    | FetchOrderSucceed OrderReceipt
    | FetchOrderFail Http.Error
    | FetchCartSucceed (List CartItem)
    | FetchCartFail Http.Error
    | UpdateSearch String
    | ClickOnSearch
