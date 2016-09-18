module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Pages.Products.Update
import Pages.Products.Messages
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
            Menu.Update.update subMsg model.menu
                |> OutMessage.mapComponent (\newChild -> { model | menu = newChild })
                |> OutMessage.mapCmd MenuMsg
                |> OutMessage.evaluateMaybe updateProductsFromMenuEvents Cmd.none

        ProductsMsg subMsg ->
            Pages.Products.Update.update subMsg model.productsPage
                |> OutMessage.mapComponent (\newChild -> { model | productsPage = newChild })
                |> OutMessage.mapCmd ProductsMsg
                |> OutMessage.evaluateMaybe updateMenuFromProductsEvents Cmd.none

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


updateMenuFromProductsEvents : GlobalEvent -> Model -> ( Model, Cmd Msg )
updateMenuFromProductsEvents msg model =
    case msg of
        NewCartWasAdded ->
            updateMenu (Menu.Messages.GlobalEvent NewCartWasAdded) model

        _ ->
            ( model, Cmd.none )


updateProductsFromMenuEvents : GlobalEvent -> Model -> ( Model, Cmd Msg )
updateProductsFromMenuEvents msg model =
    case msg of
        SearchForProduct keyword ->
            updateProducts (Pages.Products.Messages.GlobalEvent <| SearchForProduct keyword) model

        _ ->
            ( model, Cmd.none )


updateProducts : Pages.Products.Messages.Msg -> Model -> ( Model, Cmd Msg )
updateProducts msg model =
    let
        ( updatedProducts, cmds, _ ) =
            Pages.Products.Update.update msg model.productsPage
    in
        { model
            | productsPage = updatedProducts
        }
            ! [ Cmd.map ProductsMsg cmds ]


updateMenu : Menu.Messages.Msg -> Model -> ( Model, Cmd Msg )
updateMenu msg model =
    let
        ( updatedMenu, cmds, _ ) =
            Menu.Update.update msg model.menu
    in
        { model
            | menu = updatedMenu
        }
            ! [ Cmd.map MenuMsg cmds ]
