module Messages exposing (..)

import Types exposing (..)

import Http
import Navigation


type Msg
  = SignIn
  | GetMe (Result Http.Error Profile)
  | GetPlaylists (Result Http.Error PlaylistsResponse)
  | GetTracks (Result Http.Error (List Track))
  -- | AsyncSignIn (Result Http.Error Session)
  | UrlChange Navigation.Location
