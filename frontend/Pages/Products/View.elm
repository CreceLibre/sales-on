module Pages.Products.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, disabled, value, placeholder, type')
import Pages.Products.Messages exposing (..)
import Pages.Products.Models exposing (Product, ProductPageModel)
import Html.Events exposing (onClick, onInput)


view : ProductPageModel -> Html Msg
view model =
    div []
        [ searchView model.search
        , listView model
        ]


listView : ProductPageModel -> Html Msg
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


searchView : Maybe String -> Html Msg
searchView search =
    div []
        [ input [ placeholder "Search query", value (Maybe.withDefault "" search), type' "text", onInput UpdateSearch ] []
        , button [ onClick ClickOnSearch ] [ text "Buscar" ]
        ]


productRow : Product -> Html Msg
productRow product =
    tr []
        [ td [] [ text (toString product.id) ]
        , td [] [ text (toString product.name) ]
        , td [] [ text (toString product.category) ]
        , td [] [ text (toString product.price) ]
        , td [] [ button [ onClick (AddToCart product.id), disabled (not product.addToCart) ] [ text "Add to cart" ] ]
        ]
