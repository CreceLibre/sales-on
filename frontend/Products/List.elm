module Products.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Products.Messages exposing (..)
import Products.Models exposing (Product)


view : List Product -> Html Msg
view products =
    div []
        [ nav products
        , list products
        ]


list : List Product -> Html Msg
list products =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "ID" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Category" ]
                    , th [] [ text "Price" ]
                    , th [] [ ]
                    ]
                ]
            , tbody [] (List.map productRow products)
            ]
        ]


nav : List Product -> Html Msg
nav products =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ]
            [ text "Products" ]
        ]


productRow : Product -> Html Msg
productRow product =
    tr []
        [ td [] [ text (toString product.id) ]
        , td [] [ text (toString product.name) ]
        , td [] [ text (toString product.category) ]
        , td [] [ text (toString product.price) ]
        , td [] [ button [] [ text "add to cart"] ]
        ]
