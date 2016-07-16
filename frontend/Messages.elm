module Messages exposing (..)

import Http
import Models exposing (..)


type Msg
    = FetchAllProductsDone (List Product)
    | FetchAllProductsFail Http.Error
    | AddToCartSuccess
    | AddToCartFail Http.Error
    | AddToCart ProductId
    | FetchOrderDone Order'
    | FetchOrderFail Http.Error
    | UpdateSearch String
    | Click
    | FetchBreakdownsDone OrderBreakdown
    | FetchBreakdownsFail Http.Error
    | UpdateItemQuantityDone
    | UpdateItemQuantityFail Http.Error
    | IncreaseQuantity ItemId
    | DecreaseQuantity ItemId
    | ShowConfirmation
    | UpdateEmail String
    | UpdatePaymentMethod String
    | UpdatePickupLocation String
    | PlaceOrderDone String
    | PlaceOrderFail Http.Error
    | PlaceOrder
