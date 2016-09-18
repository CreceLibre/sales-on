module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Pages.Products.Update
import Pages.Confirmation.Update
import Pages.Receipt.Update
import Menu.Update
import Menu.Messages
import OutMessage
import Utils exposing (GlobalEvent(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MenuMsg subMsg ->
            updateMenu subMsg model

        ProductsMsg subMsg ->
            Pages.Products.Update.update subMsg model.productsPage
                |> OutMessage.mapComponent (\newChild -> { model | productsPage = newChild })
                |> OutMessage.mapCmd ProductsMsg
                |> OutMessage.evaluateMaybe updateMenuFromProducts Cmd.none

        ConfirmationMsg subMsg ->
            let
                ( updatedConfirmation, cmds ) =
                    Pages.Confirmation.Update.update subMsg model.confirmationPage
            in
                { model
                    | confirmationPage = updatedConfirmation
                }
                    ! [ Cmd.map ConfirmationMsg cmds ]

        ReceiptMsg subMsg ->
            let
                ( updatedReceipt, cmds ) =
                    Pages.Receipt.Update.update subMsg model.receiptPage
            in
                { model
                    | receiptPage = updatedReceipt
                }
                    ! [ Cmd.map ReceiptMsg cmds ]


updateMenuFromProducts : GlobalEvent -> Model -> ( Model, Cmd Msg )
updateMenuFromProducts msg model =
    case msg of
        NewCartWasAdded ->
            updateMenu (Menu.Messages.GlobalEvent NewCartWasAdded) model


updateMenu : Menu.Messages.Msg -> Model -> ( Model, Cmd Msg )
updateMenu msg model =
    let
        ( updatedMenu, cmds ) =
            Menu.Update.update msg model.menu
    in
        { model
            | menu = updatedMenu
        }
            ! [ Cmd.map MenuMsg cmds ]
