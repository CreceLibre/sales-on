module Views.Menu exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, placeholder, value, type')
import Routing exposing (Route(..))
import Html.Events exposing (onClick, onInput)
import State exposing (State)
import Messages exposing (Msg(..))


view : State -> Html Msg
view model =
    div [ class "pure-menu pure-menu-horizontal" ]
        [ span [ class "pure-menu-heading" ]
            [ text "Sales On" ]
        , ul [ class "pure-menu-list" ]
            (menuItems model)
        ]


searchView : Maybe String -> Html Msg
searchView search =
    li [ class "pure-menu-item" ]
        [ input [ placeholder "Search query", class "pure-input-rounded", value (Maybe.withDefault "" search), type' "text", onInput UpdateSearch ] []
        , a [ onClick ClickOnSearch, class "pure-button" ] [ text "Buscar" ]
        ]


menuItems : State -> List (Html Msg)
menuItems { cartSize, search, route } =
    let
        extraMenu =
            case route of
                --  TODO Still not sure how to be DRY here :(
                ConfirmationRoute ->
                    []

                ReceiptRoute _ ->
                    []

                _ ->
                    [ searchView search ]
                        ++ if cartSize > 0 then
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
