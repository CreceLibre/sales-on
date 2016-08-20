module Pages.Confirmation.Messages exposing (..)

import Http
import Pages.Confirmation.Models exposing (OrderBreakdown, ItemId)


type Msg
    = UpdateEmail String
    | UpdatePaymentMethod String
    | UpdatePickupLocation String
    | FetchBreakdownsDone OrderBreakdown
    | FetchBreakdownsFail Http.Error
    | UpdateItemQuantityDone
    | UpdateItemQuantityFail Http.Error
    | IncreaseQuantity ItemId
    | DecreaseQuantity ItemId
    | PlaceOrderDone String
    | PlaceOrderFail Http.Error
    | PlaceOrder
