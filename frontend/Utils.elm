module Utils exposing (..)

import Json.Decode as Json
import Html
import Html.Events exposing (on, targetValue)
import String


toMaybe : (a -> Bool) -> a -> Maybe a
toMaybe predicate a =
    if predicate a then
        Just a
    else
        Nothing



-- TODO should we decode the value here?


onChangeIntValue : (Int -> a) -> Html.Attribute a
onChangeIntValue a =
    let
        targetValueIntDecoder =
            targetValue
                `Json.andThen`
                    \val ->
                        case String.toInt val of
                            Ok i ->
                                Json.succeed i

                            Err err ->
                                Json.fail err
    in
        on "change" (Json.map a targetValueIntDecoder)
