module Menu.Messages exposing (..)

import Http
import API.Models exposing (CartItem)
import Utils exposing (GlobalEvent)


type Msg
    = FetchCartSucceed (List CartItem)
    | FetchCartFail Http.Error
    | UpdateSearch String
    | ClickOnSearch
    | GlobalEvent GlobalEvent
