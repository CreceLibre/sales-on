module Main exposing (..)

import Navigation
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Routing exposing (Route(..))
import Commands exposing (fetchProducts, fetchOrder)


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
            Commands.fetchBreakdowns

        ProductsRoute ->
            Commands.fetchProducts model.searchProduct

        ReceiptRoute orderUuid ->
            fetchOrder orderUuid

        NotFoundRoute ->
            Cmd.none


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = always Sub.none
        }
