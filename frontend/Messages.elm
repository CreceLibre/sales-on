module Messages exposing (..)

import Pages.Products.Messages
import Pages.Confirmation.Messages
import Pages.Receipt.Messages


type Msg
    = ProductsMsg Pages.Products.Messages.Msg
    | ConfirmationMsg Pages.Confirmation.Messages.Msg
    | ReceiptMsg Pages.Receipt.Messages.Msg
