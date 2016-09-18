module Models exposing (..)

import Pages.Confirmation.Models exposing (ConfirmationPageModel)
import API.Models exposing (OrderReceipt, Product, initOrderReceipt)
import Routing


type alias IndexedProduct =
    ( Int, Product )


type alias State =
    { search : Maybe String
    , products : List IndexedProduct
    , isLoading : Bool
    , confirmationPage : ConfirmationPageModel
    , receipt : OrderReceipt
    , cartSize : Int
    , search : Maybe String
    , route : Routing.Route
    }


initialState : Routing.Route -> State
initialState route =
    { search = Nothing
    , products = []
    , isLoading = False
    , confirmationPage = Pages.Confirmation.Models.init
    , receipt = initOrderReceipt
    , cartSize = 0
    , route = route
    }
