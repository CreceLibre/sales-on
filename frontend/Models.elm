module Models exposing (..)

import Pages.Products.Models exposing (ProductPageModel)
import Pages.Confirmation.Models exposing (ConfirmationPageModel)
import Menu.Models exposing (MenuModel)
import API.Models exposing (OrderReceipt, initOrderReceipt)
import Routing


type alias State =
    { productsPage : ProductPageModel
    , confirmationPage : ConfirmationPageModel
    , receipt : OrderReceipt
    , menu : MenuModel
    , route : Routing.Route
    }


initialState : Routing.Route -> State
initialState route =
    { productsPage = Pages.Products.Models.init
    , confirmationPage = Pages.Confirmation.Models.init
    , receipt = initOrderReceipt
    , menu = Menu.Models.init
    , route = route
    }
