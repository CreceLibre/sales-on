module Models exposing (..)

import Routing


type alias Id =
    Int


type alias ItemId =
    Id


type alias ProductId =
    Id


type alias Item =
    { id : ItemId
    , name : String
    , unitPrice : String
    , total : String
    , quantity : Int
    }


type alias OrderBreakdown =
    { subtotal : String
    , total : String
    , items : List Item
    }


type alias ConfirmationOrder =
    { email : String
    , paymentMethod : String
    , pickupLocation : String
    }


type alias Order' =
    { id : Int
    , email : String
    }


type alias Product =
    { id : ProductId
    , name : String
    , category : String
    , price : Int
    , addToCart : Bool
    }


type alias Model =
    { confirmationOrder : ConfirmationOrder
    , orderBreakdown : OrderBreakdown
    , receiptOrder : Order'
    , products : List Product
    , searchProduct : Maybe String
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { confirmationOrder = ConfirmationOrder "andres@otarola.me" "webpay" "galpon"
    , orderBreakdown = OrderBreakdown "" "" []
    , receiptOrder = Order' 0 ""
    , products = []
    , searchProduct = Nothing
    , route = route
    }
