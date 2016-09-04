module Pages.Receipt.View exposing (..)

import Html exposing (..)
import Pages.Receipt.Messages exposing (..)
import Pages.Receipt.Models exposing (ReceiptPageModel)


view : ReceiptPageModel -> Html Msg
view { orderReceipt } =
    div []
        [ div []
            [ strong [] [ text ("Tu numero de pedido es " ++ toString (orderReceipt.id) ++ ", te hemos enviado un correo con los detalles de tu pedido") ]
            ]
        ]
