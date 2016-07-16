module ProductSearch.Messages exposing (..)


type Msg
    = UpdateSearch String
    | Click


type OutMsg
    = NoOp
    | Search
