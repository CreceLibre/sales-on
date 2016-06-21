module Models exposing (..)

import Products.Models exposing (Product)
import Routing


type alias Model =
    { products : List Product
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { products = []
    , route = route
    }
