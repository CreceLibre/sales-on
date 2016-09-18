module Menu.Messages exposing (..)

import Http
import API.Models exposing (CartItem)
import Utils exposing (GlobalEvent)


type Msg
    = FetchAllDone (List CartItem)
    | FetchAllFail Http.Error
    | GlobalEvent GlobalEvent
