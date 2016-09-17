module Pages.Confirmation.Update exposing (..)

import Pages.Confirmation.Messages exposing (Msg(..))
import Navigation
import Pages.Confirmation.Commands
    exposing
        ( placeOrder
        , updateItem
        , fetchBreakdowns
        , removeItem
        )
import Pages.Confirmation.Models exposing (ConfirmationPageModel)
import Process
import Task
import API.Models exposing (Item, OrderBreakdown, ID)
import Utils exposing (never)


update : Msg -> ConfirmationPageModel -> ( ConfirmationPageModel, Cmd Msg )
update msg confirmationOrder =
    let
        { orderBreakdown, orderConfirmation } =
            confirmationOrder
    in
        case msg of
            Delayed newConfirmationOrder ->
                ( newConfirmationOrder, Cmd.none )

            UpdateQuantity itemId newQuantity ->
                let
                    newOrderBreakdown =
                        { orderBreakdown | items = updateQuantity itemId newQuantity orderBreakdown.items }

                    newConfirmationOrder =
                        { confirmationOrder | orderBreakdown = newOrderBreakdown }

                    oldQuantity =
                        case List.filter (\x -> x.id == itemId) orderBreakdown.items of
                            item :: _ ->
                                item.quantity

                            _ ->
                                0
                in
                    newConfirmationOrder
                        ! updateQuantityCmd itemId oldQuantity newQuantity orderBreakdown.items

            UpdateItemQuantityDone ->
                confirmationOrder
                    ! [ fetchBreakdowns ]

            UpdateItemQuantityFail itemId oldQuantity _ ->
                let
                    newOrderBreakdown =
                        { orderBreakdown | items = updateQuantity itemId oldQuantity orderBreakdown.items }

                    newConfirmationOrder =
                        { confirmationOrder | orderBreakdown = newOrderBreakdown }
                in
                    -- Okay, so this is a not-so-ugly workaround, for this `problem`
                    -- https://gist.github.com/aotarola/62c8b4a067e8d0dcb40cca9e24133566
                    -- I documented a `solution` here
                    -- https://gist.github.com/aotarola/dcc94c26d81b4093a10b92946fa624d0
                    confirmationOrder
                        ! [ Process.sleep 50
                                |> Task.perform never (always (Delayed newConfirmationOrder))
                          ]

            RemoveItem itemId ->
                confirmationOrder
                    ! [ removeItem itemId ]

            RemoveItemDone ->
                confirmationOrder
                    ! [ fetchBreakdowns ]

            RemoveItemFail err ->
                confirmationOrder
                    ! [ Cmd.none ]

            FetchBreakdownsDone newOrderBreakdown ->
                let
                    shouldRedirectToProducts =
                        if List.isEmpty newOrderBreakdown.items then
                            Navigation.newUrl "#products"
                        else
                            Cmd.none
                in
                    { confirmationOrder
                        | orderBreakdown =
                            newOrderBreakdown
                    }
                        ! [ shouldRedirectToProducts ]

            FetchBreakdownsFail _ ->
                confirmationOrder
                    ! [ Cmd.none ]

            UpdateEmail newEmail ->
                let
                    newOrderConfirmation =
                        { orderConfirmation | email = newEmail }
                in
                    { confirmationOrder
                        | orderConfirmation =
                            newOrderConfirmation
                    }
                        ! [ Cmd.none ]

            UpdatePaymentMethod newPaymentMethod ->
                let
                    newOrderConfirmation =
                        { orderConfirmation | paymentMethod = newPaymentMethod }
                in
                    { confirmationOrder
                        | orderConfirmation =
                            newOrderConfirmation
                    }
                        ! [ Cmd.none ]

            UpdatePickupLocation newPickupLocation ->
                let
                    newOrderConfirmation =
                        { orderConfirmation | pickupLocation = newPickupLocation }
                in
                    { confirmationOrder
                        | orderConfirmation =
                            newOrderConfirmation
                    }
                        ! [ Cmd.none ]

            PlaceOrderDone orderUuid ->
                confirmationOrder
                    ! [ Navigation.newUrl ("#receipt/" ++ orderUuid) ]

            PlaceOrderFail error ->
                confirmationOrder
                    ! [ Cmd.none ]

            PlaceOrder ->
                confirmationOrder
                    ! [ placeOrder confirmationOrder ]


updateQuantityCmd : ID -> Int -> Int -> List Item -> List (Cmd Msg)
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


updateQuantity : ID -> Int -> List Item -> List Item
updateQuantity itemId newQuantity items =
    let
        update item =
            if item.id == itemId then
                { item | quantity = newQuantity }
            else
                item
    in
        List.map update items
