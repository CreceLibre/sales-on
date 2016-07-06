module OrderBreakdown.Messages exposing (..)

import Http
import OrderBreakdown.Models exposing (OrderBreakdown, ItemId)


type Msg
    = FetchBreakdownsDone OrderBreakdown
    | FetchBreakdownsFail Http.Error
    | UpdateItemQuantityDone
    | UpdateItemQuantityFail Http.Error
    | IncreaseQuantity ItemId
    | DecreaseQuantity ItemId
