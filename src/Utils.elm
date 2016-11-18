module Utils exposing (..)

import Types exposing (Image)


getImageUrl : List Image -> String
getImageUrl images =
  case List.head images of
    Nothing -> ""
    Just obj ->
      case obj.url of
        Nothing -> ""
        Just imgUrl -> imgUrl
