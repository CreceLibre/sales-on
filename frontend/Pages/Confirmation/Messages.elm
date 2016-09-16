module Pages.Confirmation.Messages exposing (..)

import Http
import API.Models exposing (OrderBreakdown, ID)


type Msg
    = UpdateEmail String
    | UpdatePaymentMethod String
    | UpdatePickupLocation String
    | FetchBreakdownsDone OrderBreakdown
    | FetchBreakdownsFail Http.Error
    | UpdateQuantity ID Int
    | UpdateItemQuantityDone
    | UpdateItemQuantityFail ID Int Http.Error
    | RemoveItem ID
    | RemoveItemDone
    | RemoveItemFail Http.Error
    | PlaceOrder
    | PlaceOrderDone String
    | PlaceOrderFail Http.Error
    | Delay OrderBreakdown
