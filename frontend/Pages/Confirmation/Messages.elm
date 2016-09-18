module Pages.Confirmation.Messages exposing (..)

import Http
import API.Models exposing (OrderBreakdown, ID)
import Pages.Confirmation.Models exposing (ConfirmationPageModel)


type Msg
    = UpdateEmail String
    | UpdatePaymentMethod String
    | UpdatePickupLocation String
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
    | Delayed ConfirmationPageModel
    | Reset
