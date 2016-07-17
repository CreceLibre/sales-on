module Pages.Products.Models exposing (..)


type alias ProductId =
    Int


type alias Product =
    { id : ProductId
    , name : String
    , category : String
    , price : Int
    , addToCart : Bool
    }


type alias IndexedProduct = (Int, Product)


type alias ProductPageModel =
    { search : Maybe String
    , products : List IndexedProduct
    , isLoading : Bool
    }


init : ProductPageModel
init =
    ProductPageModel Nothing [] True
