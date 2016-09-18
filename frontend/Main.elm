module Main exposing (..)

import Navigation
import Messages exposing (Msg(..))
import Models exposing (State, initialState)
import View exposing (view)
import Update exposing (update)
import Routing exposing (Route(..))
import Commands
    exposing
        ( fetchOrder
        , fetchProducts
        , fetchCart
        , fetchBreakdowns
        , resetState
        )


init : Result String Route -> ( State, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result

        model =
            initialState currentRoute
    in
        urlUpdate result model


urlUpdate : Result String Route -> State -> ( State, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        { model | route = currentRoute } ! urlUpdateCommand model currentRoute


urlUpdateCommand : State -> Route -> List (Cmd Msg)
urlUpdateCommand model route =
    case route of
        ConfirmationRoute ->
            [ fetchBreakdowns ]

        ProductsRoute ->
            [ fetchProducts Nothing
            , fetchCart
            , resetState
            ]

        ReceiptRoute orderUuid ->
            [ fetchOrder orderUuid ]

        NotFoundRoute ->
            [ Cmd.none ]


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = always Sub.none
        }
