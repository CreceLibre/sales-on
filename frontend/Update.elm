module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (State)
import Pages.Confirmation.Update
import API.Models exposing (ID)
import Models exposing (IndexedProduct)
import Commands exposing (addProductToCart, fetchProducts)


update : Msg -> State -> ( State, Cmd Msg )
update msg model =
    case msg of
        FetchCartSucceed cartItems ->
            ( { model | cartSize = List.length cartItems }
            , Cmd.none
            )

        FetchCartFail error ->
            ( model, Cmd.none )

        UpdateSearch keyword ->
            let
                search =
                    if keyword == "" then
                        Nothing
                    else
                        Just keyword
            in
                ( { model | search = search }, Cmd.none )

        ClickOnSearch ->
            ( model, Cmd.none )

        FetchProductsSuccess response ->
            let
                newProducts =
                    (List.indexedMap (\i p -> ( i + 1, p )) response)
            in
                ( { model
                    | products = newProducts
                    , isLoading = False
                  }
                , Cmd.none
                )

        FetchProductsFail error ->
            ( { model | isLoading = False }, Cmd.none )

        AddToCart productId ->
            let
                newProducts =
                    List.map (updateCartStatus productId True) model.products
            in
                ( { model | products = newProducts }
                , addToCartCommands productId model.products |> Cmd.batch
                )

        AddToCartSuccess ->
            ( { model | cartSize = model.cartSize + 1 }, Cmd.none )

        AddToCartFail productId error ->
            let
                newProducts =
                    List.map (updateCartStatus productId False) model.products
            in
                ( { model | products = newProducts }
                , Cmd.none
                )

        ConfirmationMsg subMsg ->
            let
                ( updatedConfirmation, cmds ) =
                    Pages.Confirmation.Update.update subMsg model.confirmationPage
            in
                { model
                    | confirmationPage = updatedConfirmation
                }
                    ! [ Cmd.map ConfirmationMsg cmds ]

        FetchOrderSucceed updatedOrder ->
            { model | receipt = updatedOrder }
                ! [ Cmd.none ]

        FetchOrderFail error ->
            model
                ! [ Cmd.none ]


updateCartStatus : ID -> Bool -> IndexedProduct -> IndexedProduct
updateCartStatus productId status indexedProduct =
    let
        ( index, product ) =
            indexedProduct
    in
        if product.id == productId then
            ( index, { product | isInCart = status } )
        else
            ( index, product )


addToCartCommands : ID -> List IndexedProduct -> List (Cmd Msg)
addToCartCommands productId =
    let
        cmdForProduct ( index, product ) =
            if product.id == productId then
                addProductToCart productId
            else
                Cmd.none
    in
        List.map cmdForProduct
