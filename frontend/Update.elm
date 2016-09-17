module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Pages.Products.Update exposing (OutMsg(..))
import Pages.Confirmation.Update
import Pages.Receipt.Update
import Menu.Update
import Menu.Models exposing (MenuModel)
import Menu.Messages


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MenuMsg subMsg ->
            let
                ( updatedMenu, cmds ) =
                    Menu.Update.update subMsg model.menu
            in
                { model
                    | menu = updatedMenu
                }
                    ! [ Cmd.map MenuMsg cmds ]

        ProductsMsg subMsg ->
            let
                ( updatedProducts, cmds, outMsg ) =
                    Pages.Products.Update.update subMsg model.productsPage

                newMenu =
                    updateMenuFromProducts outMsg model.menu
            in
                { model
                    | productsPage = updatedProducts
                    , menu = newMenu
                }
                    ! [ Cmd.map ProductsMsg cmds ]

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


updateMenuFromProducts : Maybe OutMsg -> MenuModel -> MenuModel
updateMenuFromProducts msg menu =
    case msg of
        Just NewCartItem ->
            Menu.Update.update Menu.Messages.NewCartItem menu |> fst

        Nothing ->
            menu
