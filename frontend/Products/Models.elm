module Products.Models exposing (..)


type alias ProductId =
    Int


type alias Product =
    { id : ProductId
    , name : String
    , category : String
    , price : Int
    , addToCart : Bool
    }


type alias ProductPageModel =
    { search : Maybe String
    , products : List Product
    , isLoading : Bool
    }

init : ProductPageModel
init =
  ProductPageModel Nothing [] True
