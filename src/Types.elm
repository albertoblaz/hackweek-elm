module Types exposing (..)

import Navigation


-- MODEL

type alias Model =
  { users : List User
  , playlists : List Playlist
  , tracks : List Track
  , isSignedIn : Bool
  , isPlaying : Bool
  , session : Maybe Session
  , errorMessage : Maybe String
  , history : List Navigation.Location
  }


-- Playlist

type alias PlaylistsResponse =
  { href : String
  , items : List Playlist
  }

type alias Playlist =
  { id : String
  , tracks : String
  , uri : String
  }


-- Artist

type alias Artist =
  { id : String
  , name : String
  , href : String
  }


-- Album

type alias Album =
  { id : String
  , name : String
  , href : String
  , images : List Image
  }


-- Track

type alias TracksResponse =
  { href : String
  , items : List Track
  }

type alias Track =
  { id : String
  , name : String
  , preview_url : Maybe String
  -- , artists : List Artist
  , album : Album
  }


-- Profile

type alias Profile =
  { id : String
  , href : String
  , uri : String
  , product : String
  , display_name : String
  , email : String
  , country : String
  , images : List Image
  , followers : Followers
  }

type alias Followers =
  { href : Maybe String
  , total : Int
  }

type alias Image =
  { height : Maybe Int
  , width : Maybe Int
  , url : Maybe String
  }


-- User

type alias User =
  { profile : Profile
  , score : Int
  }


-- Session

type alias Session =
  { accessToken : String
  , tokenType : String
  , scope : String
  , expiresIn : Int
  , refreshToken : String
  }


nullSession : Session
nullSession =
  { accessToken = ""
  , tokenType = ""
  , scope = ""
  , expiresIn = 0
  , refreshToken = ""
  }
