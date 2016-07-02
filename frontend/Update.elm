module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Products.Update
import SearchProduct.Update
import Confirmation.Update
import SearchProduct.Messages exposing (OutMsg(..))
import Products.Commands exposing (fetchAll)
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

        SearchProductMsg subMsg ->
            let
                ( updatedSearchProduct, cmds, signalToProcess ) =
                    SearchProduct.Update.update subMsg model.searchProduct

                ( newModel, cmdFromSignal ) =
                    processSignal signalToProcess { model | searchProduct = updatedSearchProduct }
            in
                ( newModel
                , Cmd.batch
                    [ Cmd.map SearchProductMsg cmds
                    , cmdFromSignal
                    ]
                )


        ShowConfirmation ->
            ( model, Navigation.newUrl "#confirmation")


processSignal : SearchProduct.Messages.OutMsg -> Model -> ( Model, Cmd Msg )
processSignal signal model =
    case signal of
        NoOp ->
            ( model, Cmd.none )

        Search ->
            ( model, Cmd.map ProductsMsg (fetchAll model.searchProduct) )
