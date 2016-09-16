module Models exposing (..)

import Pages.Products.Models exposing (ProductPageModel)
import Pages.Confirmation.Models exposing (ConfirmationPageModel)
import Pages.Receipt.Models exposing (ReceiptPageModel)
import Routing


type alias Model =
    { confirmationPage : ConfirmationPageModel
    , receiptPage : ReceiptPageModel
    , productsPage : ProductPageModel
    , cartSize : Int
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { confirmationPage = Pages.Confirmation.Models.init
    , receiptPage = Pages.Receipt.Models.init
    , productsPage = Pages.Products.Models.init
    , cartSize = 0
    , route = route
    }
