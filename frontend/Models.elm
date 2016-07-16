module Models exposing (..)

import Products.Models exposing (Product)
import ProductSearch.Models exposing (ProductSearch)
import Confirmation.Models exposing (ConfirmationOrder)
import Receipt.Models exposing (Order')
import Routing


type alias Model =
    { confirmationOrder : ConfirmationOrder
    , receiptOrder : Order'
    , products : List Product
    , productSearch : ProductSearch
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { confirmationOrder = Confirmation.Models.init
    , receiptOrder = Receipt.Models.init
    , products = []
    , productSearch = ProductSearch.Models.init
    , route = route
    }
