module Models exposing (..)

import Products.Models exposing (ProductPageModel)
import Confirmation.Models exposing (ConfirmationOrder)
import Receipt.Models exposing (Order')
import Routing


type alias Model =
    { confirmationOrder : ConfirmationOrder
    , receiptOrder : Order'
    , productsPage : ProductPageModel
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { confirmationOrder = Confirmation.Models.init
    , receiptOrder = Receipt.Models.init
    , productsPage = Products.Models.init
    , route = route
    }
