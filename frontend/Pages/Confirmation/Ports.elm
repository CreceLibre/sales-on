port module Pages.Confirmation.Ports exposing (..)

import API.Models exposing (OrderBreakdown)


-- Outgoing Ports


port delayRenderCmd : OrderBreakdown -> Cmd msg



-- Incoming Ports


port delayRenderSub : (OrderBreakdown -> msg) -> Sub msg
