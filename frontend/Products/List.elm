module Products.List exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (class)
import Products.Messages exposing (..)
import Products.Models exposing (Product)
import AddToCart.View

view : List Product -> Html Msg
view products =
  list products


list : List Product -> Html Msg
list products =
  if List.isEmpty products then
    text "No se encontraron productos"
  else
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "ID" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Category" ]
                    , th [] [ text "Price" ]
                    , th [] []
                    ]
                ]
            , tbody [] (List.map productRow products)
            ]
        ]


productRow : Product -> Html Msg
productRow product =
    tr []
        [ td [] [ text (toString product.id) ]
        , td [] [ text (toString product.name) ]
        , td [] [ text (toString product.category) ]
        , td [] [ text (toString product.price) ]
        , td [] [ Html.App.map (AddToCartMsg product.id) (AddToCart.View.view product.addToCart) ]
        ]
