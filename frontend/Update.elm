module Update exposing (..)

import Process
import Task
import Navigation
import Basics.Extra exposing (never)
import Messages exposing (Msg(..))
import API.Models exposing (ID, OrderBreakdownItem, OrderBreakdown)
import State exposing (State, IndexedProduct, initConfirmationState, initSearchState)
import Utils exposing (toMaybe)
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
update msg state =
    case msg of
        FetchCartSucceed cartItems ->
            let
                newState =
                    { state | cartSize = List.length cartItems }
            in
                newState ! [ Cmd.none ]

        FetchCartFail error ->
            state ! [ Cmd.none ]

        UpdateSearch keyword ->
            let
                newState =
                    { state | search = toMaybe (\x -> x /= "") keyword }
            in
                newState ! [ Cmd.none ]

        ClickOnSearch ->
            ( state, fetchProducts state.search )

        FetchProductsSuccess response ->
            let
                newProducts =
                    (List.indexedMap (\i p -> ( i + 1, p )) response)
            in
                ( { state
                    | products = newProducts
                    , isLoading = False
                  }
                , Cmd.none
                )

        FetchProductsFail error ->
            ( { state | isLoading = False }, Cmd.none )

        AddToCart productId ->
            let
                newProducts =
                    List.map (updateCartStatus productId True) state.products
            in
                ( { state | products = newProducts }
                , addToCartCommands productId state.products |> Cmd.batch
                )

        AddToCartSuccess ->
            ( { state | cartSize = state.cartSize + 1 }, Cmd.none )

        AddToCartFail productId error ->
            let
                newProducts =
                    List.map (updateCartStatus productId False) state.products
            in
                ( { state | products = newProducts }
                , Cmd.none
                )

        FetchOrderSucceed updatedOrder ->
            { state | receipt = updatedOrder }
                ! [ Cmd.none ]

        FetchOrderFail error ->
            state
                ! [ Cmd.none ]

        ResetConfirmation ->
            ( initConfirmationState state, Cmd.none )

        ResetSearch ->
            ( initSearchState state, Cmd.none )

        Delayed state ->
            ( state, Cmd.none )

        UpdateQuantity itemId oldQuantity newQuantity ->
            let
                { orderBreakdown } =
                    state

                newOrderBreakdown =
                    { orderBreakdown | items = updateQuantity itemId newQuantity orderBreakdown.items }

                updatedModel =
                    { state | orderBreakdown = newOrderBreakdown }
            in
                updatedModel
                    ! updateQuantityCmd itemId oldQuantity newQuantity orderBreakdown.items

        UpdateItemQuantitySucceed ->
            state
                ! [ fetchBreakdowns ]

        UpdateItemQuantityFail itemId oldQuantity _ ->
            let
                { orderBreakdown } =
                    state

                newOrderBreakdown =
                    { orderBreakdown | items = updateQuantity itemId oldQuantity orderBreakdown.items }

                updatedModel =
                    { state | orderBreakdown = newOrderBreakdown }
            in
                -- Okay, so this is a not-so-ugly workaround, for this `problem`
                -- https://gist.github.com/aotarola/62c8b4a067e8d0dcb40cca9e24133566
                -- I documented a `solution` here
                -- https://gist.github.com/aotarola/dcc94c26d81b4093a10b92946fa624d0
                state
                    ! [ Process.sleep 50
                            |> Task.perform never (always <| Delayed updatedModel)
                      ]

        RemoveItem itemId ->
            state
                ! [ removeItem itemId ]

        RemoveItemSucceed ->
            state
                ! [ fetchBreakdowns ]

        RemoveItemFail err ->
            state
                ! [ Cmd.none ]

        FetchBreakdownsSucceed newOrderBreakdown ->
            let
                shouldShowProducts =
                    if List.isEmpty newOrderBreakdown.items then
                        Navigation.newUrl "#products"
                    else
                        Cmd.none
            in
                { state
                    | orderBreakdown =
                        newOrderBreakdown
                }
                    ! [ shouldShowProducts ]

        FetchBreakdownsFail _ ->
            state
                ! [ Cmd.none ]

        UpdateEmail newEmail ->
            let
                { orderConfirmation } =
                    state

                newOrderConfirmation =
                    { orderConfirmation | email = newEmail }
            in
                { state
                    | orderConfirmation =
                        newOrderConfirmation
                }
                    ! [ Cmd.none ]

        PlaceOrderSucceed orderUuid ->
            initConfirmationState state
                ! [ Navigation.newUrl ("#receipt/" ++ orderUuid) ]

        PlaceOrderFail error ->
            state
                ! [ Cmd.none ]

        PlaceOrder ->
            state
                ! [ placeOrder state ]


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
