port module Ports exposing (..)


-- Outgoing Ports

port fetchProductsCmd : (Maybe String) -> Cmd msg



-- Incoming Ports


port fetchProductsSub : (Maybe String -> msg) -> Sub msg
