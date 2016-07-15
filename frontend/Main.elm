module Main exposing (..)

import Navigation
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Routing exposing (Route(..))
import Confirmation.Commands
import Products.Commands
import Receipt.Commands
import Products.Subscriptions


init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result

        model =
            initialModel currentRoute
    in
        urlUpdate result model


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map ProductsMsg (Products.Subscriptions.subscriptions model.products)


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
            Cmd.map ConfirmationMsg Confirmation.Commands.fetchBreakdowns

        ProductsRoute ->
            Cmd.map ProductsMsg (Products.Commands.fetch model.searchProduct)

        ReceiptRoute orderUuid ->
            Cmd.map ReceiptMsg (Receipt.Commands.fetch orderUuid)

        NotFoundRoute ->
            Cmd.none


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
