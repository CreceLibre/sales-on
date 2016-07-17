module Pages.Receipt.View exposing (..)

import Html exposing (..)
import Pages.Receipt.Messages exposing (..)
import Pages.Receipt.Models exposing (Order')


view : Order' -> Html Msg
view order =
    div []
        [ div []
            [ strong [] [ text ("Tu numero de pedido es " ++ toString (order.id) ++ ", te hemos enviado un correo con los detalles de tu pedido") ]
            ]
        ]
