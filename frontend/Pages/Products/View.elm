module Pages.Products.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src, hidden)
import Messages exposing (Msg(..))
import Html.Events exposing (onClick, onInput)
import Capitalize
import Models exposing (State, IndexedProduct)


view : State -> Html Msg
view model =
    div [] [ listView model ]


listView : State -> Html Msg
listView model =
    let
        { products, isLoading } =
            model
    in
        if List.isEmpty products then
            if isLoading then
                text "Cargando..."
            else
                text "No se encontraron productos"
        else
            div [ class "pure-g" ] (List.map productRow products)


productRow : IndexedProduct -> Html Msg
productRow ( index, product ) =
    div [ class "pure-u-1 pure-u-md-1-2 pure-u-lg-1-4" ]
        [ div [ class "card-spacing" ]
            [ div [ class "card", onClick (AddToCart product.id) ]
                [ div [ class "image" ]
                    [ img [ class "pure-img", src "http://placehold.it/600x455" ] []
                    , div [ class "info", hidden (not product.isInCart) ]
                        [ span [] [ text "En Carro" ]
                        ]
                    ]
                , figcaption []
                    [ p [] [ text (Capitalize.toCapitalAll product.name) ]
                    , div [ class "price" ] [ text product.price ]
                    ]
                ]
            ]
        ]


oddClassName : Int -> String
oddClassName id =
    if id % 2 == 0 then
        "pure-table-odd"
    else
        ""
