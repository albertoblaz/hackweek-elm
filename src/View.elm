module View exposing (render)

import Html exposing (Html, div, h1, h2, text)
-- import Html.Events exposing (onClick)

import Types exposing (Model)
import Messages exposing (Msg)

import View.TopBar
import View.Users
import View.SongPlayer


render : Model -> Html Msg
render model =
  if model.isSignedIn
  then viewSession model
  else viewNoSession


viewSession : Model -> Html Msg
viewSession model =
  div []
    [ View.TopBar.render
    , View.Users.render model.users
    , View.SongPlayer.render model.tracks
    ]


viewNoSession : Html Msg
viewNoSession =
  div []
    [ h1 [] [ text "Spotify App" ]
    , h2 [] [ text "Yo! Sign in to join the room" ]
    -- , button [ onClick SignIn ] [ text "Sign in!" ]
    -- , button []
    --     [ a [ href loginURL ] [ text "Sign in!" ]
    --     ]
    ]
