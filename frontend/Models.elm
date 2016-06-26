module Models exposing (..)

import Products.Models exposing (Product)
import SearchProduct.Models exposing (SearchProduct)
import Routing


type alias Model =
    { products : List Product
    , searchProduct : SearchProduct
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { products = []
    , searchProduct = Nothing
    , route = route
    }
