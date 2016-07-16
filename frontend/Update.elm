module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (..)
import Navigation
import Commands exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchAllProductsDone newProducts ->
            ( { model | products = newProducts }, Cmd.none )

        FetchAllProductsFail error ->
            ( model, Cmd.none )

        AddToCart productId ->
            ( model, addToCartCommands productId model.products |> Cmd.batch )

        AddToCartSuccess ->
            ( model, Cmd.none )

        AddToCartFail error ->
            ( model, Cmd.none )

        FetchOrderDone updatedOrder ->
            ( { model | receiptOrder = updatedOrder }, Cmd.none )

        FetchOrderFail error ->
            ( model, Cmd.none )

        UpdateSearch keyword ->
            let
                term =
                    if keyword == "" then
                        Nothing
                    else
                        Just keyword
            in
                ( { model | searchProduct = term }, Cmd.none )

        Click ->
            ( model, fetchProducts model.searchProduct )

        ShowConfirmation ->
            ( model, Navigation.newUrl "#confirmation" )

        IncreaseQuantity itemId ->
            ( model, updateQuantityCmd itemId 1 model.orderBreakdown.items |> Cmd.batch )

        DecreaseQuantity itemId ->
            ( model, updateQuantityCmd itemId -1 model.orderBreakdown.items |> Cmd.batch )

        UpdateItemQuantityDone ->
            ( model, fetchBreakdowns )

        UpdateItemQuantityFail _ ->
            ( model, Cmd.none )

        FetchBreakdownsDone newOrderBreakdown ->
            ( { model | orderBreakdown = newOrderBreakdown }, Cmd.none )

        FetchBreakdownsFail _ ->
            ( model, Cmd.none )

        UpdateEmail newEmail ->
            let
                confirmationOrder =
                    model.confirmationOrder

                newConfirmationOrder =
                    { confirmationOrder | email = newEmail }
            in
                ( { model | confirmationOrder = newConfirmationOrder }, Cmd.none )

        UpdatePaymentMethod newPaymentMethod ->
            let
                confirmationOrder =
                    model.confirmationOrder

                newConfirmationOrder =
                    { confirmationOrder | paymentMethod = newPaymentMethod }
            in
                ( { model | confirmationOrder = newConfirmationOrder }, Cmd.none )

        UpdatePickupLocation newPickupLocation ->
            let
                confirmationOrder =
                    model.confirmationOrder

                newConfirmationOrder =
                    { confirmationOrder | pickupLocation = newPickupLocation }
            in
                ( { model | confirmationOrder = newConfirmationOrder }, Cmd.none )

        PlaceOrderDone orderUuid ->
            ( model, Navigation.newUrl ("#receipt/" ++ orderUuid) )

        PlaceOrderFail error ->
            ( model, Cmd.none )

        PlaceOrder ->
            ( model, placeOrder model.confirmationOrder )


addToCartCommands : ProductId -> List Product -> List (Cmd Msg)
addToCartCommands productId =
    let
        cmdForProduct product =
            if product.id == productId then
                addProductToCart productId
            else
                Cmd.none
    in
        List.map cmdForProduct


updateQuantityCmd : ItemId -> Int -> List Item -> List (Cmd Msg)
updateQuantityCmd itemId howMuch items =
    let
        update item =
            if item.id == itemId then
                if howMuch < 0 && item.quantity <= 1 then
                    Cmd.none
                else
                    updateItem itemId (item.quantity + howMuch)
            else
                Cmd.none
    in
        List.map update items


updateQuantity : ItemId -> Int -> List Item -> List Item
updateQuantity itemId newQuantity items =
    let
        update item =
            if item.id == itemId then
                { item | quantity = newQuantity }
            else
                item
    in
        List.map update items
