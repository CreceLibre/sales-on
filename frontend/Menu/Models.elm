module Menu.Models exposing (..)


type alias MenuModel =
    { cartSize : Int
    }


init : MenuModel
init =
    MenuModel 0
