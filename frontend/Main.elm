module Main exposing (..)

import Navigation
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Routing exposing (Route(..))
import Pages.Confirmation.Commands
import Pages.Products.Commands
import Pages.Receipt.Commands
import Pages.Confirmation.Subscriptions


init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result

        model =
            initialModel currentRoute
    in
        urlUpdate result model


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( { model | route = currentRoute }, urlUpdateCommand model currentRoute )


urlUpdateCommand : Model -> Route -> Cmd Msg
urlUpdateCommand model route =
    case route of
        ConfirmationRoute ->
            Cmd.map ConfirmationMsg Pages.Confirmation.Commands.fetchBreakdowns

        ProductsRoute ->
            Cmd.map ProductsMsg (Pages.Products.Commands.fetch model.productsPage)

        ReceiptRoute orderUuid ->
            Cmd.map ReceiptMsg (Pages.Receipt.Commands.fetch orderUuid)

        NotFoundRoute ->
            Cmd.none


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map ConfirmationMsg (Pages.Confirmation.Subscriptions.subscriptions model.confirmationPage)


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
