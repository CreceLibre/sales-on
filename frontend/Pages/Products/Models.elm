module Pages.Products.Models exposing (..)

import API.Models exposing (Product)


type alias IndexedProduct =
    ( Int, Product )


type alias ProductPageModel =
    { search : Maybe String
    , products : List IndexedProduct
    , cartSize : Int
    , isLoading : Bool
    }


init : ProductPageModel
init =
    ProductPageModel Nothing [] 0 True
