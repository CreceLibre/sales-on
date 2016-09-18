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
import Pages.Confirmation.Models exposing (ConfirmationPageModel, init)
import Process
import Task
import API.Models exposing (OrderBreakdownItem, OrderBreakdown, ID)
import Basics.Extra exposing (never)


update : Msg -> ConfirmationPageModel -> ( ConfirmationPageModel, Cmd Msg )
update msg confirmationOrder =
    let
        { orderBreakdown, orderConfirmation } =
            confirmationOrder
    in
        case msg of
            Reset ->
                ( init, Cmd.none )

            Delayed newConfirmationOrder ->
                ( newConfirmationOrder, Cmd.none )

            UpdateQuantity itemId oldQuantity newQuantity ->
                let
                    newOrderBreakdown =
                        { orderBreakdown | items = updateQuantity itemId newQuantity orderBreakdown.items }

                    newConfirmationOrder =
                        { confirmationOrder | orderBreakdown = newOrderBreakdown }
                in
                    newConfirmationOrder
                        ! updateQuantityCmd itemId oldQuantity newQuantity orderBreakdown.items

            UpdateItemQuantitySucceed ->
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
                                |> Task.perform never (always <| Delayed newConfirmationOrder)
                          ]

            RemoveItem itemId ->
                confirmationOrder
                    ! [ removeItem itemId ]

            RemoveItemSucceed ->
                confirmationOrder
                    ! [ fetchBreakdowns ]

            RemoveItemFail err ->
                confirmationOrder
                    ! [ Cmd.none ]

            FetchBreakdownsSucceed newOrderBreakdown ->
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

            PlaceOrderSucceed orderUuid ->
                init
                    ! [ Navigation.newUrl ("#receipt/" ++ orderUuid) ]

            PlaceOrderFail error ->
                confirmationOrder
                    ! [ Cmd.none ]

            PlaceOrder ->
                confirmationOrder
                    ! [ placeOrder confirmationOrder ]


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
