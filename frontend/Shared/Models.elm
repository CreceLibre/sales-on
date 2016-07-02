module Shared.Models exposing (..)

type alias Amount =
    { currencyCode : String
    , amount : Int
    , formattedAmount : String
    }

initAmount : Amount
initAmount =
  Amount "" 0 ""
