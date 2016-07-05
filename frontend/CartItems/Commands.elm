module CartItems.Commands exposing (..)

import Http
import Task
import CartItems.Messages exposing (..)
import CartItems.Models exposing (CartItemId)
import Json.Encode as Encode
import Json.Decode as Decode exposing ((:=))


updateCartItemUrl : String
updateCartItemUrl =
    "/api/v1/cart"


updateCartItemTask : CartItemId -> Int -> Task.Task Http.Error (CartItemId, Int)
updateCartItemTask cartItemId howMuch =
    let
        body =
            memberEncoded cartItemId howMuch
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = "PUT"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = updateCartItemUrl
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson (Decode.succeed (cartItemId, howMuch))


updateCartItem : CartItemId -> Int -> Cmd Msg
updateCartItem cartItemId howMuch =
    updateCartItemTask cartItemId howMuch
        |> Task.perform UpdateCartItemQuantityFail UpdateCartItemQuantityDone


memberEncoded : CartItemId -> Int -> Encode.Value
memberEncoded cartItemId howMuch =
    let
        list =
            [ ( "product_id", Encode.int cartItemId )
            , ( "quantity", Encode.int howMuch )
            ]
    in
        list
            |> Encode.object
