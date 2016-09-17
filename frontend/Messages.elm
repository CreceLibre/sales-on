module Messages exposing (..)

import Pages.Products.Messages
import Pages.Confirmation.Messages
import Pages.Receipt.Messages
import Menu.Messages


type Msg
    = ProductsMsg Pages.Products.Messages.Msg
    | ConfirmationMsg Pages.Confirmation.Messages.Msg
    | ReceiptMsg Pages.Receipt.Messages.Msg
    | MenuMsg Menu.Messages.Msg
