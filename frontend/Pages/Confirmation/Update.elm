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
import API.Models exposing (Item, OrderBreakdown, ID)
import Pages.Confirmation.Ports exposing (..)


update : Msg -> ConfirmationPageModel -> ( ConfirmationPageModel, Cmd Msg )
update msg confirmationOrder =
    let
        { orderBreakdown, orderConfirmation } =
            confirmationOrder
    in
        case msg of
            Delay newOrderBreakdown ->
                ( { confirmationOrder | orderBreakdown = newOrderBreakdown }, Cmd.none )

            UpdateQuantity itemId newQuantity ->
                let
                    newOrderBreakdown =
                        { orderBreakdown | items = updateQuantity itemId newQuantity orderBreakdown.items }

                    oldQuantity =
                        case List.filter (\x -> x.id == itemId) orderBreakdown.items of
                            item :: _ ->
                                item.quantity

                            _ ->
                                0
                in
                    ( { confirmationOrder | orderBreakdown = newOrderBreakdown }
                    , updateQuantityCmd itemId oldQuantity newQuantity orderBreakdown.items
                        |> Cmd.batch
                    )

            UpdateItemQuantityDone ->
                ( confirmationOrder, fetchBreakdowns )

            UpdateItemQuantityFail itemId oldQuantity _ ->
                let
                    newOrderBreakdown =
                        { orderBreakdown | items = updateQuantity itemId oldQuantity orderBreakdown.items }
                in
                    ( confirmationOrder, delayRenderCmd newOrderBreakdown )

            RemoveItem itemId ->
                ( confirmationOrder, removeItem itemId )

            RemoveItemDone ->
                ( confirmationOrder, fetchBreakdowns )

            RemoveItemFail err ->
                ( confirmationOrder, Cmd.none )

            FetchBreakdownsDone newOrderBreakdown ->
                let
                    shouldRedirectToProducts =
                        if List.isEmpty newOrderBreakdown.items then
                            Navigation.newUrl "#products"
                        else
                            Cmd.none
                in
                    ( { confirmationOrder
                        | orderBreakdown =
                            newOrderBreakdown
                      }
                    , shouldRedirectToProducts
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
