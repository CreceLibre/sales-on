module OrderBreakdown.Update exposing (..)

import OrderBreakdown.Messages exposing (Msg(..))
import OrderBreakdown.Models exposing (OrderBreakdown, Item, ItemId)
import OrderBreakdown.Commands exposing (updateItem, fetchAll)

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

update : Msg -> OrderBreakdown -> ( OrderBreakdown, Cmd Msg )
update msg orderBreakdown =
    case msg of

        IncreaseQuantity itemId ->
            ( orderBreakdown, updateQuantityCmd itemId 1 orderBreakdown.items |> Cmd.batch )

        DecreaseQuantity itemId ->
            ( orderBreakdown, updateQuantityCmd itemId -1 orderBreakdown.items |> Cmd.batch )

        UpdateItemQuantityDone ->
            ( orderBreakdown, fetchAll )

        UpdateItemQuantityFail _ ->
            ( orderBreakdown, Cmd.none )

        FetchBreakdownsDone newOrderBreakdown ->
            ( newOrderBreakdown, Cmd.none )

        FetchBreakdownsFail _ ->
            ( orderBreakdown, Cmd.none )
