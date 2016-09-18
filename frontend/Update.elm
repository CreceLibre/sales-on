module Update exposing (..)

import Process
import Task
import Navigation
import Basics.Extra exposing (never)
import Messages exposing (Msg(..))
import Models exposing (State)
import API.Models exposing (ID, OrderBreakdownItem, OrderBreakdown)
import Models exposing (IndexedProduct, initConfirmationState)
import Commands
    exposing
        ( addProductToCart
        , fetchProducts
        , updateItem
        , fetchBreakdowns
        , removeItem
        , placeOrder
        )


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
            ( model, fetchProducts model.search )

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

        FetchOrderSucceed updatedOrder ->
            { model | receipt = updatedOrder }
                ! [ Cmd.none ]

        FetchOrderFail error ->
            model
                ! [ Cmd.none ]

        Reset ->
            ( initConfirmationState model, Cmd.none )

        Delayed state ->
            ( state, Cmd.none )

        UpdateQuantity itemId oldQuantity newQuantity ->
            let
                { orderBreakdown } =
                    model

                newOrderBreakdown =
                    { orderBreakdown | items = updateQuantity itemId newQuantity orderBreakdown.items }

                updatedModel =
                    { model | orderBreakdown = newOrderBreakdown }
            in
                updatedModel
                    ! updateQuantityCmd itemId oldQuantity newQuantity orderBreakdown.items

        UpdateItemQuantitySucceed ->
            model
                ! [ fetchBreakdowns ]

        UpdateItemQuantityFail itemId oldQuantity _ ->
            let
                { orderBreakdown } =
                    model

                newOrderBreakdown =
                    { orderBreakdown | items = updateQuantity itemId oldQuantity orderBreakdown.items }

                updatedModel =
                    { model | orderBreakdown = newOrderBreakdown }
            in
                -- Okay, so this is a not-so-ugly workaround, for this `problem`
                -- https://gist.github.com/aotarola/62c8b4a067e8d0dcb40cca9e24133566
                -- I documented a `solution` here
                -- https://gist.github.com/aotarola/dcc94c26d81b4093a10b92946fa624d0
                model
                    ! [ Process.sleep 50
                            |> Task.perform never (always <| Delayed updatedModel)
                      ]

        RemoveItem itemId ->
            model
                ! [ removeItem itemId ]

        RemoveItemSucceed ->
            model
                ! [ fetchBreakdowns ]

        RemoveItemFail err ->
            model
                ! [ Cmd.none ]

        FetchBreakdownsSucceed newOrderBreakdown ->
            let
                shouldShowProducts =
                    if List.isEmpty newOrderBreakdown.items then
                        Navigation.newUrl "#products"
                    else
                        Cmd.none
            in
                { model
                    | orderBreakdown =
                        newOrderBreakdown
                }
                    ! [ shouldShowProducts ]

        FetchBreakdownsFail _ ->
            model
                ! [ Cmd.none ]

        UpdateEmail newEmail ->
            let
                { orderConfirmation } =
                    model

                newOrderConfirmation =
                    { orderConfirmation | email = newEmail }
            in
                { model
                    | orderConfirmation =
                        newOrderConfirmation
                }
                    ! [ Cmd.none ]

        PlaceOrderSucceed orderUuid ->
            initConfirmationState model
                ! [ Navigation.newUrl ("#receipt/" ++ orderUuid) ]

        PlaceOrderFail error ->
            model
                ! [ Cmd.none ]

        PlaceOrder ->
            model
                ! [ placeOrder model ]


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


updateQuantityCmd : ID -> Int -> Int -> List OrderBreakdownItem -> List (Cmd Msg)
updateQuantityCmd itemId oldValue howMuch items =
    let
        update item =
            if item.id == itemId then
                if howMuch == item.quantity then
                    Cmd.none
                else
                    updateItem itemId oldValue howMuch
            else
                Cmd.none
    in
        List.map update items


updateQuantity : ID -> Int -> List OrderBreakdownItem -> List OrderBreakdownItem
updateQuantity itemId newQuantity items =
    let
        update item =
            if item.id == itemId then
                { item | quantity = newQuantity }
            else
                item
    in
        List.map update items
