module View.TopBar exposing (render)

import Html exposing (Html, div, img, h1, h2, text)
import Html.Attributes exposing (style, src)

import Messages exposing (Msg)


render : Html Msg
render =
  div
    [ style
      [ ("background", "#161616")
      , ("margin", "0")
      , ("padding", ".5em 0")
      , ("color", "#dfe0e6")
      , ("font-family", "sans-serif")
      , ("letter-spacing", "4px")
      , ("text-transform", "uppercase")
      , ("text-align", "center")
      ]
    ]
    [ img [ src "/public/assets/logos/spotify-logo.png" ] []
    , h1
        [ style
          [ ("font-size", "30px")
          , ("font-weight", "100")
          ]
        ] [ text "Spotify App" ]
    , h2
        [ style
          [ ("font-size", "15px")
          , ("font-weight", "100")
          , ("margin-left", "15px")
          ]
        ] [ text "powered by Elm" ]
    ]
