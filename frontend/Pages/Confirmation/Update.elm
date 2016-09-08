module Pages.Confirmation.Update exposing (..)

import Pages.Confirmation.Messages exposing (Msg(..))
import Navigation
import Pages.Confirmation.Commands
    exposing
        ( placeOrder
        , updateItem
        , fetchBreakdowns
        )
import Pages.Confirmation.Models exposing (ConfirmationOrder)
import API.Models exposing (Item, OrderBreakdown)


update : Msg -> ConfirmationOrder -> ( ConfirmationOrder, Cmd Msg )
update msg confirmationOrder =
    let
        { orderBreakdown, orderConfirmation } =
            confirmationOrder
    in
        case msg of
            IncreaseQuantity itemId ->
                ( confirmationOrder
                , updateQuantityCmd itemId 1 orderBreakdown.items
                    |> Cmd.batch
                )

            DecreaseQuantity itemId ->
                ( confirmationOrder
                , updateQuantityCmd itemId -1 orderBreakdown.items
                    |> Cmd.batch
                )

            UpdateItemQuantityDone ->
                ( confirmationOrder, fetchBreakdowns )

            UpdateItemQuantityFail _ ->
                ( confirmationOrder, Cmd.none )

            FetchBreakdownsDone newOrderBreakdown ->
                ( { confirmationOrder
                    | orderBreakdown =
                        newOrderBreakdown
                  }
                , Cmd.none
                )

            FetchBreakdownsFail _ ->
                ( confirmationOrder, Cmd.none )

            UpdateEmail newEmail ->
                let
                    newOrderConfirmation =
                        { orderConfirmation | email = newEmail }
                in
                    ( { confirmationOrder
                        | orderConfirmation =
                            newOrderConfirmation
                      }
                    , Cmd.none
                    )

            UpdatePaymentMethod newPaymentMethod ->
                let
                    newOrderConfirmation =
                        { orderConfirmation | paymentMethod = newPaymentMethod }
                in
                    ( { confirmationOrder
                        | orderConfirmation =
                            newOrderConfirmation
                      }
                    , Cmd.none
                    )

            UpdatePickupLocation newPickupLocation ->
                let
                    newOrderConfirmation =
                        { orderConfirmation | pickupLocation = newPickupLocation }
                in
                    ( { confirmationOrder
                        | orderConfirmation =
                            newOrderConfirmation
                      }
                    , Cmd.none
                    )

            PlaceOrderDone orderUuid ->
                ( confirmationOrder, Navigation.newUrl ("#receipt/" ++ orderUuid) )

            PlaceOrderFail error ->
                ( confirmationOrder, Cmd.none )

            PlaceOrder ->
                ( confirmationOrder, placeOrder confirmationOrder )


updateQuantityCmd : Int -> Int -> List Item -> List (Cmd Msg)
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


updateQuantity : Int -> Int -> List Item -> List Item
updateQuantity itemId newQuantity items =
    let
        update item =
            if item.id == itemId then
                { item | quantity = newQuantity }
            else
                item
    in
        List.map update items
