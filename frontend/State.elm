module State exposing (..)

import Routing
import API.Models
    exposing
        ( OrderReceipt
        , Product
        , OrderBreakdown
        , OrderConfirmation
        , initOrderReceipt
        , initOrderConfirmation
        , initOrderBreakdown
        )


type alias IndexedProduct =
    ( Int, Product )


type alias State =
    { search : Maybe String
    , products : List IndexedProduct
    , isLoading : Bool
    , orderConfirmation : OrderConfirmation
    , orderBreakdown : OrderBreakdown
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
    , orderConfirmation = initOrderConfirmation
    , orderBreakdown = initOrderBreakdown
    , receipt = initOrderReceipt
    , cartSize = 0
    , route = route
    }


initConfirmationState : State -> State
initConfirmationState state =
    { state
        | orderConfirmation = initOrderConfirmation
        , orderBreakdown = initOrderBreakdown
    }
