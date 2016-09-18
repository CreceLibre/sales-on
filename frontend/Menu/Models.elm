module Menu.Models exposing (..)


type alias MenuModel =
    { cartSize : Int
    , search : Maybe String
    }


init : MenuModel
init =
    MenuModel 0 Nothing
