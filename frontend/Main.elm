module Main exposing (..)

import Navigation
import Messages exposing (Msg(..))
import Models exposing (State, initialState)
import View exposing (view)
import Update exposing (update)
import Routing exposing (Route(..))
import Pages.Confirmation.Commands exposing (fetchBreakdowns, resetState)
import Pages.Products.Commands exposing (fetchProducts)
import Commands exposing (fetchOrder)
import Menu.Commands exposing (fetchCart)


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
            [ Cmd.map ConfirmationMsg fetchBreakdowns ]

        ProductsRoute ->
            [ Cmd.map ProductsMsg <| fetchProducts Nothing
            , Cmd.map MenuMsg fetchCart
            , Cmd.map ConfirmationMsg resetState
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
