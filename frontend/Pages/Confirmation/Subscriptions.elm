module Pages.Confirmation.Subscriptions exposing (..)

import Pages.Confirmation.Messages exposing (Msg(..))
import Pages.Confirmation.Models exposing (ConfirmationPageModel)
import Pages.Confirmation.Ports exposing (..)


subscriptions : ConfirmationPageModel -> Sub Msg
subscriptions model =
    delayRenderSub Delay
