module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (State)
import Pages.Products.Update
import Pages.Products.Messages
import Pages.Confirmation.Update
import Menu.Update
import Menu.Messages
import OutMessage
import Utils exposing (GlobalEvent(..))


update : Msg -> State -> ( State, Cmd Msg )
update msg model =
    case msg of
        MenuMsg subMsg ->
            Menu.Update.update subMsg model.menu
                |> OutMessage.mapComponent (\newChild -> { model | menu = newChild })
                |> OutMessage.mapCmd MenuMsg
                |> OutMessage.evaluateMaybe updateFromMenuEvents Cmd.none

        ProductsMsg subMsg ->
            Pages.Products.Update.update subMsg model.productsPage
                |> OutMessage.mapComponent (\newChild -> { model | productsPage = newChild })
                |> OutMessage.mapCmd ProductsMsg
                |> OutMessage.evaluateMaybe updateFromProductsEvents Cmd.none

        ConfirmationMsg subMsg ->
            let
                ( updatedConfirmation, cmds ) =
                    Pages.Confirmation.Update.update subMsg model.confirmationPage
            in
                { model
                    | confirmationPage = updatedConfirmation
                }
                    ! [ Cmd.map ConfirmationMsg cmds ]

        FetchOrderSucceed updatedOrder ->
            { model | receipt = updatedOrder }
                ! [ Cmd.none ]

        FetchOrderFail error ->
            model
                ! [ Cmd.none ]


updateFromProductsEvents : GlobalEvent -> State -> ( State, Cmd Msg )
updateFromProductsEvents msg model =
    case msg of
        NewCartWasAdded ->
            updateMenu (Menu.Messages.GlobalEvent NewCartWasAdded) model

        FetchAllProducts ->
            updateMenu (Menu.Messages.GlobalEvent FetchAllProducts) model

        _ ->
            ( model, Cmd.none )


updateFromMenuEvents : GlobalEvent -> State -> ( State, Cmd Msg )
updateFromMenuEvents msg model =
    case msg of
        SearchForProduct keyword ->
            updateProducts (Pages.Products.Messages.GlobalEvent <| SearchForProduct keyword) model

        _ ->
            ( model, Cmd.none )


updateProducts : Pages.Products.Messages.Msg -> State -> ( State, Cmd Msg )
updateProducts msg model =
    let
        ( updatedProducts, cmds, _ ) =
            Pages.Products.Update.update msg model.productsPage
    in
        { model
            | productsPage = updatedProducts
        }
            ! [ Cmd.map ProductsMsg cmds ]


updateMenu : Menu.Messages.Msg -> State -> ( State, Cmd Msg )
updateMenu msg model =
    let
        ( updatedMenu, cmds, _ ) =
            Menu.Update.update msg model.menu
    in
        { model
            | menu = updatedMenu
        }
            ! [ Cmd.map MenuMsg cmds ]
