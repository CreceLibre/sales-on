module Receipt.View exposing (..)

import Html exposing (..)
import Receipt.Messages exposing (..)
import Receipt.Models exposing (Order')


view : Order' -> Html Msg
view order =
    div []
        [ div []
            [ strong [] [ text ("Tu numero de pedido es " ++ toString (order.id) ++ ", te hemos enviado un correo con los detalles de tu pedido") ]
            ]
        ]
