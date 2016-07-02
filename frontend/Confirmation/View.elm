module Confirmation.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Confirmation.Messages exposing (..)
import Confirmation.Models exposing (ConfirmationOrder)


view : ConfirmationOrder -> Html Msg
view order =
    div []
        [ input [ placeholder "Correo", value order.email, type' "text", onInput UpdateEmail ] []
        , div []
          [
          strong [] [ text "Método de Pago"]
          ]
        ]
