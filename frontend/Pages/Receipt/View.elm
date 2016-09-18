module Pages.Receipt.View exposing (..)

import Html exposing (..)
import Models exposing (State)
import Messages exposing (Msg(..))


view : State -> Html Msg
view { receipt } =
    div []
        [ div []
            [ strong [] [ text ("Tu numero de pedido es " ++ toString (receipt.id) ++ ", te hemos enviado un correo con los detalles de tu pedido") ]
            ]
        ]
