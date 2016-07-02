module Confirmation.Commands exposing (..)

import Confirmation.Messages exposing (..)
import OrderBreakdown.Commands


fetchAll : Cmd Msg
fetchAll =
    Cmd.map OrderBreakdownMsg OrderBreakdown.Commands.fetchAll
