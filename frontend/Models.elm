module Models exposing (..)

import Pages.Products.Models exposing (ProductPageModel)
import Pages.Confirmation.Models exposing (ConfirmationOrder)
import Pages.Receipt.Models exposing (ReceiptPageModel)
import Routing


type alias Model =
    { confirmationPage : ConfirmationOrder
    , receiptPage : ReceiptPageModel
    , productsPage : ProductPageModel
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { confirmationPage = Pages.Confirmation.Models.init
    , receiptPage = Pages.Receipt.Models.init
    , productsPage = Pages.Products.Models.init
    , route = route
    }
