module Pages.Confirmation.Messages exposing (..)

import Http
import API.Models exposing (OrderBreakdown)


type Msg
    = UpdateEmail String
    | UpdatePaymentMethod String
    | UpdatePickupLocation String
    | FetchBreakdownsDone OrderBreakdown
    | FetchBreakdownsFail Http.Error
    | UpdateItemQuantityDone
    | UpdateItemQuantityFail Http.Error
    | IncreaseQuantity Int
    | DecreaseQuantity Int
    | PlaceOrderDone String
    | PlaceOrderFail Http.Error
    | PlaceOrder
