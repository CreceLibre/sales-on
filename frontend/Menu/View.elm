module Menu.View exposing (..)

import Html exposing (..)
import Menu.Messages exposing (..)
import Menu.Models exposing (MenuModel)
import Html.Attributes exposing (class, href)
import Routing exposing (Route(..))


-- TODO SEARCH functionality should be moved here (probably)


view : MenuModel -> Routing.Route -> Html Msg
view model currentRoute =
    div [ class "pure-menu pure-menu-horizontal" ]
        [ span [ class "pure-menu-heading" ]
            [ text "Sales On" ]
        , ul [ class "pure-menu-list" ]
            (menuItems model currentRoute)
        ]


menuItems : MenuModel -> Routing.Route -> List (Html Msg)
menuItems model route =
    let
        extraMenu =
            case route of
                --  TODO Still not sure how to be DRY here :(
                ConfirmationRoute ->
                    []

                ReceiptRoute _ ->
                    []

                _ ->
                    if model.cartSize > 0 then
                        [ li [ class "pure-menu-item" ]
                            [ a [ class "pure-menu-link", href "#confirmation" ]
                                [ text "Confirmación de Compra" ]
                            ]
                        ]
                    else
                        []
    in
        [ li [ class "pure-menu-item" ]
            [ a [ class "pure-menu-link", href "#products" ]
                [ text "Productos" ]
            ]
        ]
            ++ extraMenu
