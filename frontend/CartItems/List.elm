module CartItems.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, disabled)
import CartItems.Messages exposing (..)
import CartItems.Models exposing (CartItem)
-- import Html.Events exposing (onClick)

view : List CartItem -> Html Msg
view cartItems =
  list cartItems


list : List CartItem -> Html Msg
list cartItems =
  if List.isEmpty cartItems then
    text "No se encontraron productos :("
  else
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "ID" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Price" ]
                    , th [] [ text "Quantity" ]
                    ]
                ]
            , tbody [] (List.map row cartItems)
            ]
        ]


row : CartItem -> Html Msg
row cartItem =
    tr []
        [ td [] [ text (toString cartItem.id) ]
        , td [] [ text (toString cartItem.name) ]
        , td [] [ text (toString cartItem.unitPrice.formattedAmount) ]
        , td [] [ text (toString cartItem.quantity) ]
        ]
