module Menu.View exposing (..)

import Html exposing (..)
import Menu.Messages exposing (..)
import Menu.Models exposing (MenuModel)
import Html.Attributes exposing (class, href, placeholder, value, type')
import Routing exposing (Route(..))
import Html.Events exposing (onClick, onInput)


view : MenuModel -> Routing.Route -> Html Msg
view model currentRoute =
    div [ class "pure-menu pure-menu-horizontal" ]
        [ span [ class "pure-menu-heading" ]
            [ text "Sales On" ]
        , ul [ class "pure-menu-list" ]
            (menuItems model currentRoute)
        ]


searchView : Maybe String -> Html Msg
searchView search =
    li [ class "pure-menu-item" ]
        [ input [ placeholder "Search query", class "pure-input-rounded", value (Maybe.withDefault "" search), type' "text", onInput UpdateSearch ] []
        , a [ onClick ClickOnSearch, class "pure-button" ] [ text "Buscar" ]
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
                    [ searchView model.search ]
                        ++ if model.cartSize > 0 then
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
