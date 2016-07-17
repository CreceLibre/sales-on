module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Products.Update
import Confirmation.Update
import Receipt.Update
import Navigation


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ProductsMsg subMsg ->
            let
                ( updatedProducts, cmds ) =
                    Products.Update.update subMsg model.productsPage
            in
                ( { model | productsPage = updatedProducts }, Cmd.map ProductsMsg cmds )

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

        ShowConfirmation ->
            ( model, Navigation.newUrl "#confirmation" )
