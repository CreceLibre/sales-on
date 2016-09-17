module Pages.Confirmation.Messages exposing (..)

import Http
import API.Models exposing (OrderBreakdown, ID)
import Pages.Confirmation.Models exposing (ConfirmationPageModel)


type Msg
    = UpdateEmail String
    | UpdatePaymentMethod String
    | UpdatePickupLocation String
    | FetchBreakdownsDone OrderBreakdown
    | FetchBreakdownsFail Http.Error
    | UpdateQuantity ID Int Int
    | UpdateItemQuantityDone
    | UpdateItemQuantityFail ID Int Http.Error
    | RemoveItem ID
    | RemoveItemDone
    | RemoveItemFail Http.Error
    | PlaceOrder
    | PlaceOrderDone String
    | PlaceOrderFail Http.Error
    | Delayed ConfirmationPageModel
