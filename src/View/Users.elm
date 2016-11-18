module View.Users exposing (render)

import Html exposing (Html, div, h2, text)
import Html.Attributes exposing (style)

import Types exposing (User)
import Messages exposing (Msg)
import View.User


render : List User -> Html Msg
render users =
  div
    [ style
      [ ("position", "fixed")
      , ("left", "0")
      , ("height", "100%")
      , ("background", "#1c1c1f")
      ] ]
    [ h2
      [ style
        [ ("font-family", "sans-serif")
        , ("font-weight", "100")
        , ("color", "#dfe0e6")
        , ("font-size", "14px")
        , ("padding", "10px 25px")
        , ("margin", "0")
        , ("text-transform", "uppercase")
        , ("border-bottom", "1px solid #AAA")
        ]
      ] [ text "Users" ]
    , div [] (List.map View.User.render users)
    ]
