module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Products.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ProductsMsg subMsg ->
            let
                ( updatedProducts, cmd ) =
                    Products.Update.update subMsg model.products
            in
                ( { model | products = updatedProducts }, Cmd.map ProductsMsg cmd )
