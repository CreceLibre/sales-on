module Messages exposing (..)

import Http
import Pages.Products.Messages
import Pages.Confirmation.Messages
import Menu.Messages
import API.Models exposing (OrderReceipt)


type Msg
    = ProductsMsg Pages.Products.Messages.Msg
    | ConfirmationMsg Pages.Confirmation.Messages.Msg
    | MenuMsg Menu.Messages.Msg
    | FetchOrderSucceed OrderReceipt
    | FetchOrderFail Http.Error
