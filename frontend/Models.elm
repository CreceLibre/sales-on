module Models exposing (..)

import Products.Models exposing (Product)
import SearchProduct.Models exposing (SearchProduct)
import Confirmation.Models exposing (ConfirmationOrder)
import Routing


type alias Model =
    { confirmationOrder : ConfirmationOrder
    , products : List Product
    , searchProduct : SearchProduct
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { confirmationOrder = Confirmation.Models.init
    , products = []
    , searchProduct = SearchProduct.Models.init
    , route = route
    }
