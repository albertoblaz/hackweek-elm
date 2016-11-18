module Rest exposing
  ( getMeCall
  , getMe
  , getPlaylistsCall
  , getPlaylists
  , getTracksCall
  , getTracks
  , decodeError
  )

import Constants exposing (accessToken)
import Types exposing (..)
import Messages exposing (..)

import Json.Decode as Decode exposing (Decoder, nullable, string, int, list, field)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)

import Http



-- Get Me

getMeCall : Cmd Msg
getMeCall =
  Http.send GetMe getMe


getMe : Http.Request Profile
getMe =
  Http.request
    { method = "GET"
    , headers = [ Http.header "Authorization" ("Bearer " ++ accessToken) ]
    , url = "https://api.spotify.com/v1/me"
    , body = Http.emptyBody
    , expect = (Http.expectJson getMeDecoder)
    , timeout = Nothing
    , withCredentials = False
    }

getMeDecoder : Decoder Profile
getMeDecoder =
  decode Profile
    |> required "id" string
    |> required "href" string
    |> required "uri" string
    |> required "product" string
    |> required "display_name" string
    |> optional "email" string "no email"
    |> optional "country" string "non-specified"
    |> optional "images" (list decodeImage) []
    |> required "followers" decodeFollowers

decodeImage : Decoder Image
decodeImage =
  decode Image
    |> required "height" (nullable int)
    |> required "width" (nullable int)
    |> optional "url" (nullable string) (Just "http://localhost:8000/public/assets/images/anonymous.jpg")


decodeFollowers : Decoder Followers
decodeFollowers =
  decode Followers
    |> required "href" (nullable string)
    |> required "total" int



-- Playlists

getPlaylistsCall : String -> Cmd Msg
getPlaylistsCall userId =
  Http.send GetPlaylists (getPlaylists userId)


getPlaylists : String -> Http.Request PlaylistsResponse
getPlaylists userId =
  Http.request
    { method = "GET"
    , headers = [ Http.header "Authorization" ("Bearer " ++ accessToken) ]
    , url = "https://api.spotify.com/v1/users/" ++ userId ++ "/playlists/"
    , body = Http.emptyBody
    , expect = (Http.expectJson decodePlaylistsResponse)
    , timeout = Nothing
    , withCredentials = False
    }

decodePlaylistsResponse : Decoder PlaylistsResponse
decodePlaylistsResponse =
  decode PlaylistsResponse
    |> required "href" string
    |> required "items" (list decodePlaylist)

decodePlaylist : Decoder Playlist
decodePlaylist =
  decode Playlist
    |> required "id" string
    |> required "tracks" (field "href" string)
    |> required "uri" string



-- Tracks

getTracksCall : String -> Cmd Msg
getTracksCall url =
  Http.send GetTracks (getTracks url)

getTracks : String -> Http.Request (List Track)
getTracks tracksUrl =
  Http.request
    { method = "GET"
    , headers = [ Http.header "Authorization" ("Bearer " ++ accessToken) ]
    , url = tracksUrl
    , body = Http.emptyBody
    , expect = (Http.expectJson decodeTracksResponse)
    , timeout = Nothing
    , withCredentials = False
    }

-- https://api.spotify.com/v1/tracks/7pk3EpFtmsOdj8iUhjmeCM
decodeTracksResponse : Decoder (List Track)
decodeTracksResponse =
  Decode.at
    ["items"]
    (list
      (Decode.at ["track"] decodeTrack))

decodeTrack : Decoder Track
decodeTrack =
  decode Track
    |> required "id" string
    |> required "name" string
    |> optional "preview_url" (nullable string) Nothing
    -- |> required "artists" (list decodeArtist)
    |> required "album" decodeAlbum

decodeArtist : Decoder Artist
decodeArtist =
  decode Artist
    |> required "id" string
    |> required "name" string
    |> required "href" string

decodeAlbum : Decoder Album
decodeAlbum =
  decode Album
    |> required "id" string
    |> required "name" string
    |> required "href" string
    |> required "images" (list decodeImage)



-- Login

-- loginURL : String
-- loginURL =
--   "https://accounts.spotify.com/authorize/" ++
--     "?client_id=" ++ clientId ++
--     "&response_type=" ++ responseType ++
--     "&redirect_uri=" ++ redirectUri ++
--     "&scope=" ++ "user-read-private%20user-read-email" ++
--     "&state=" ++ state ++
--     "&show_dialog=" ++ toString showDialog

--
-- login : Cmd Msg
-- login =
  -- Http.send AsyncSignIn (Http.get loginURL decodeLogin)


-- decodeLogin : Decoder Session
-- decodeLogin =
--   decode Session
--     |> required "accessToken" string
--     |> required "tokenType" string
--     |> required "scope" string
--     |> required "expiresIn" int
--     |> required "refreshToken" string



-- Aux Decode Error

decodeError : Http.Error -> String
decodeError err =
  case err of
    Http.Timeout ->
      "Time exceeded by the request"
    Http.NetworkError ->
      "Can not connect due to a network error"
    Http.BadStatus body ->
      "Bad Status " ++ body.body
    Http.BadPayload data body ->
      "Bad Payload" ++ toString body ++ toString data
    _ ->
      "Unexpected error: " ++ toString err
