module Menu.Update exposing (..)

import Menu.Messages exposing (Msg(..))
import Menu.Models exposing (MenuModel)
import Utils exposing (GlobalEvent(..))


update : Msg -> MenuModel -> ( MenuModel, Cmd Msg )
update msg model =
    case msg of
        FetchAllDone cartItems ->
            { model | cartSize = List.length cartItems }
                ! [ Cmd.none ]

        FetchAllFail error ->
            model
                ! [ Cmd.none ]

        GlobalEvent e ->
            case e of
                NewCartWasAdded ->
                    { model | cartSize = model.cartSize + 1 }
                        ! [ Cmd.none ]
