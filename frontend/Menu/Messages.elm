module Menu.Messages exposing (..)

import Http
import API.Models exposing (CartItem)


type Msg
    = FetchAllDone (List CartItem)
    | FetchAllFail Http.Error
    | NewCartItem
