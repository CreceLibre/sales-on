module Messages exposing (..)

import Http
import API.Models
    exposing
        ( OrderReceipt
        , Product
        , ID
        , CartItem
        , OrderBreakdown
        )
import State exposing (State)


type Msg
    = FetchProductsSuccess (List Product)
    | FetchProductsFail Http.Error
    | AddToCart ID
    | AddToCartSuccess
    | AddToCartFail ID Http.Error
    | FetchOrderSucceed OrderReceipt
    | FetchOrderFail Http.Error
    | FetchCartSucceed (List CartItem)
    | FetchCartFail Http.Error
    | UpdateSearch String
    | ClickOnSearch
    | UpdateEmail String
    | FetchBreakdownsSucceed OrderBreakdown
    | FetchBreakdownsFail Http.Error
    | UpdateQuantity ID Int Int
    | UpdateItemQuantitySucceed
    | UpdateItemQuantityFail ID Int Http.Error
    | RemoveItem ID
    | RemoveItemSucceed
    | RemoveItemFail Http.Error
    | PlaceOrder
    | PlaceOrderSucceed String
    | PlaceOrderFail Http.Error
    | Delayed State
    | ResetConfirmation
    | ResetSearch
