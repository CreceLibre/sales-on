module Models exposing (..)

import Pages.Products.Models exposing (ProductPageModel)
import Pages.Confirmation.Models exposing (ConfirmationPageModel)
import Pages.Receipt.Models exposing (ReceiptPageModel)
import Menu.Models exposing (MenuModel)
import Routing


type alias State =
    { confirmationPage : ConfirmationPageModel
    , receiptPage : ReceiptPageModel
    , productsPage : ProductPageModel
    , menu : MenuModel
    , route : Routing.Route
    }


initialState : Routing.Route -> State
initialState route =
    { confirmationPage = Pages.Confirmation.Models.init
    , receiptPage = Pages.Receipt.Models.init
    , productsPage = Pages.Products.Models.init
    , menu = Menu.Models.init
    , route = route
    }
