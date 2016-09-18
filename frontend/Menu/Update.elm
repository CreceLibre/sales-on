module Menu.Update exposing (..)

import Menu.Messages exposing (Msg(..))
import Menu.Models exposing (MenuModel)
import Utils exposing (GlobalEvent(..))


update : Msg -> MenuModel -> ( MenuModel, Cmd Msg, Maybe GlobalEvent )
update msg model =
    case msg of
        FetchCartSucceed cartItems ->
            ( { model | cartSize = List.length cartItems }
            , Cmd.none
            , Nothing
            )

        FetchCartFail error ->
            ( model, Cmd.none, Nothing )

        GlobalEvent e ->
            case e of
                NewCartWasAdded ->
                    ( { model | cartSize = model.cartSize + 1 }, Cmd.none, Nothing )

                FetchAllProducts ->
                    ( { model | search = Nothing }, Cmd.none, Nothing )

                _ ->
                    ( model, Cmd.none, Nothing )

        UpdateSearch keyword ->
            let
                search =
                    if keyword == "" then
                        Nothing
                    else
                        Just keyword
            in
                ( { model | search = search }, Cmd.none, Nothing )

        ClickOnSearch ->
            ( model, Cmd.none, Just <| SearchForProduct model.search )
