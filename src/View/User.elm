module View.User exposing (render)

import Html exposing (Html, div, img, h3, p, text)
import Html.Attributes exposing (style, src)

import Types exposing (User)
import Messages exposing (Msg)
import Utils exposing (getImageUrl)


render : User -> Html Msg
render { profile, score } =
  div
    [ style
      [ ("padding", "20px")
      , ("width", "300px")
      , ("height", "65px")
      , ("border-bottom", "1px solid #AAA")
      ]
    ]
    [ img
        [ src (getImageUrl profile.images)
        , style
            [ ("display", "inline-block")
            , ("border-radius", "100%")
            , ("height", "65px")
            , ("width", "65px")
            , ("float", "left")
            ]
        ]
        []
    , div
        [ style
          [ ("display", "inline-block")
          , ("margin-left", "25px")
          , ("margin-top", "10px")
          , ("float", "left")
          ]
        ]
        [ h3
          [ style
            [ ("margin-top", "0")
            , ("color", "#dfe0e6")
            , ("font-family", "sans-serif")
            , ("font-weight", "100")
            , ("margin-bottom", "10px")
            ]
          ] [ text profile.display_name ]
        , p
            [ style
              [ ("font-family", "sans-serif")
              , ("font-size", "14px")
              , ("font-weight", "100")
              , ("color", "#dfe0e6")
              , ("margin", "0")
              ]
            ]
            [ text ("Username: " ++ profile.id) ]
        ]
    , div
        [ style
          [ ("font-size", "35px")
          , ("font-family", "sans-serif")
          , ("font-weight", "100")
          , ("color", "#dfe0e6")
          , ("margin-right", "10px")
          , ("margin-top", "15px")
          , ("display", "inline-block")
          , ("float", "right")
          ]
        ] [ text (toString score) ]
    ]
