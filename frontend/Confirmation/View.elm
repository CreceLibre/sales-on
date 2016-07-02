module Confirmation.View exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Confirmation.Messages exposing (..)
import Confirmation.Models exposing (ConfirmationOrder)
import OrderBreakdown.View


view : ConfirmationOrder -> Html Msg
view confirmationOrder =
    div []
        [ input [ placeholder "Correo", value confirmationOrder.email, type' "text", onInput UpdateEmail ] []
        , div []
            [ strong [] [ text "Método de Pago" ]
            ]
        , Html.App.map OrderBreakdownMsg (OrderBreakdown.View.overview confirmationOrder.orderBreakdown)
        , Html.App.map OrderBreakdownMsg (OrderBreakdown.View.yourItems confirmationOrder.orderBreakdown)
        ]
