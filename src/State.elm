module State exposing (init, update, subscriptions)

import Messages exposing (..)
import Rest exposing (..)
import Types exposing (..)

import Http
import Navigation


-- init : (Model, Cmd Msg)
-- init =
init : Navigation.Location -> (Model, Cmd Msg)
init location =
  let
    anonImage = "http://localhost:8000/public/assets/images/anonymous.jpg"
    image = Image Nothing Nothing (Just anonImage)
    followers = Followers Nothing 0
    profile = Profile "" "" "" "" "Ronaldo" "" "" [image] followers
    mockUser = User profile 7
    users = [mockUser]

    playlists = []

    tracks = []

    isSignedIn = True

    isPlaying = False

    session = Nothing

    errorMessage = Nothing

    history = [location]
  in
    ( Model
      users
      playlists
      tracks
      isSignedIn
      isPlaying
      session
      errorMessage
      history
    , getMeCall)


updateFail : Model -> Http.Error -> (Model, Cmd Msg)
updateFail model err =
  ({ model
   | errorMessage = Just (decodeError err)
   }, Cmd.none)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    -- SignIn ->
    --   ( Model
    --     users
    --     isSignedIn
    --     Nothing
    --     Nothing
    --   , login)

    GetMe (Ok profile) ->
      ({ model
       | users = (( User profile 0 ) :: model.users)
       , errorMessage = Nothing
       }, getPlaylistsCall profile.id)

    GetMe (Err err) ->
      updateFail model err


    GetPlaylists (Ok { href, items }) ->
      let
        tracks = List.map (\p -> p.tracks) items
      in
        ({ model
         | playlists = (List.append items model.playlists)
         }, Cmd.batch (
            (List.map getTracksCall tracks)
            -- , playRandomSong model
          )
        )

    GetPlaylists (Err err) ->
      updateFail model err


    GetTracks (Ok tracksResponse) ->
      ({ model
       | tracks = (List.append tracksResponse model.tracks)
       }, Cmd.none)

    GetTracks (Err err) ->
      updateFail model err


    -- AsyncSignIn (Ok session) ->
    --   ( Model
    --     ((User "Alberto" 0 "pic.jpg") :: [])
    --     True
    --     (Just session)
    --     Nothing
    --     history
    --   , Cmd.none)
    --   -- , login)
    --
    -- AsyncSignIn (Err err) ->
    --   ( Model
    --     []
    --     False
    --     Nothing
    --     -- (Just (decodeLoginError err))
    --     (Just (toString err))
    --     history
    --   , Cmd.none)


    UrlChange location ->
      ({ model
       | history = (location :: model.history)
       }, Cmd.none)


    _ ->
      (model, Cmd.none)


-- playRandomSong : Model -> Cmd Msg
-- playRandomSong model =
--   case List.head model.tracks of
--     Nothing ->
--       Cmd.none
--
--     Just song ->
--       Audio.play


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
