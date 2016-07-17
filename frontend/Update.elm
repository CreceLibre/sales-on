module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Pages.Products.Update
import Pages.Confirmation.Update
import Pages.Receipt.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ProductsMsg subMsg ->
            let
                ( updatedProducts, cmds ) =
                    Pages.Products.Update.update subMsg model.productsPage
            in
                ( { model | productsPage = updatedProducts }, Cmd.map ProductsMsg cmds )

        ConfirmationMsg subMsg ->
            let
                ( updatedConfirmation, cmds ) =
                    Pages.Confirmation.Update.update subMsg model.confirmationPage
            in
                ( { model | confirmationPage = updatedConfirmation }, Cmd.map ConfirmationMsg cmds )

        ReceiptMsg subMsg ->
            let
                ( updatedReceipt, cmds ) =
                    Pages.Receipt.Update.update subMsg model.receiptPage
            in
                ( { model | receiptPage = updatedReceipt }, Cmd.map ReceiptMsg cmds )
