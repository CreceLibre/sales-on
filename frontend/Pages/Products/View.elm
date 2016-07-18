module Pages.Products.View exposing (..)

import Html exposing (..)
import Html.Attributes
    exposing
        ( class
        , disabled
        , value
        , placeholder
        , type'
        )
import Pages.Products.Messages exposing (..)
import Pages.Products.Models exposing (Product, ProductPageModel, IndexedProduct)
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
            div []
                [ table [ class "pure-table" ]
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


productRow : IndexedProduct -> Html Msg
productRow (index, product) =
    tr [ class (oddClassName index) ]
        [ td [] [ text (toString index) ]
        , td [] [ text product.name ]
        , td [] [ text product.category ]
        , td [] [ text product.price ]
        , td [] [ button [ onClick (AddToCart product.id), disabled product.isInCart ] [ text "Add to cart" ] ]
        ]

oddClassName : Int -> String
oddClassName id =
  if id%2 == 0 then
    "pure-table-odd"
  else
    ""
