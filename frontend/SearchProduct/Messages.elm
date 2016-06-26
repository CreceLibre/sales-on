module SearchProduct.Messages exposing (..)


type Msg
    = UpdateSearch String
    | Click


type OutMsg
    = NoOp
    | Search
