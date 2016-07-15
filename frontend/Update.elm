module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Products.Update
import SearchProduct.Update
import Confirmation.Update
import Receipt.Update
import Navigation


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ProductsMsg subMsg ->
            let
                ( updatedProducts, cmds ) =
                    Products.Update.update subMsg model.products
            in
                ( { model | products = updatedProducts }, Cmd.map ProductsMsg cmds )

        ConfirmationMsg subMsg ->
            let
                ( updatedConfirmation, cmds ) =
                    Confirmation.Update.update subMsg model.confirmationOrder
            in
                ( { model | confirmationOrder = updatedConfirmation }, Cmd.map ConfirmationMsg cmds )

        ReceiptMsg subMsg ->
            let
                ( updatedReceipt, cmds ) =
                    Receipt.Update.update subMsg model.receiptOrder
            in
                ( { model | receiptOrder = updatedReceipt }, Cmd.map ReceiptMsg cmds )

        SearchProductMsg subMsg ->
            let
                ( updatedSearchProduct, cmds ) =
                    SearchProduct.Update.update subMsg model.searchProduct
            in
                ( { model | searchProduct = updatedSearchProduct }, Cmd.map SearchProductMsg cmds )

        ShowConfirmation ->
            ( model, Navigation.newUrl "#confirmation" )
