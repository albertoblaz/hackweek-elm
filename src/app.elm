import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Http exposing (..)

import Json.Decode as Decode

main =
  Html.program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


-- MODEL


type alias Model =
  { users : List User
  , isSignedIn : Bool
  }


type alias User =
  { name : String
  , score : Int
  , avatarUrl : String
  }


init : (Model, Cmd Msg)
init =
  let
    isSignedIn = False

    u1 =
      { name = "Alberto"
      , score = 42
      , avatarUrl = "http://localhost:8000/images/alberto.jpg"
      }

    u2 =
      { name = "Ronaldo"
      , score = 33
      , avatarUrl = "http://localhost:8000/images/ronaldo.jpg"
      }
  in
    ( Model
      [ u1, u2 ]
      isSignedIn
    , Cmd.none)


-- UPDATE


type Msg
  = SignIn
  | FetchSong
  | NewGif (Result Http.Error String)


update : Msg -> Model -> (Model, Cmd Msg)
update msg {users, isSignedIn} =
  case msg of
    SignIn ->
      (Model users True, Cmd.none)

    _ ->
      (Model users isSignedIn, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW


view : Model -> Html Msg
view model =
  if model.isSignedIn
  then viewSession model
  else viewNoSession


viewSession : Model -> Html Msg
viewSession model =
  div []
    [ h1 [] [ text "Spotify App" ]
    , div [] (List.map viewUser model.users)
    ]


viewUser : User -> Html Msg
viewUser {name, score, avatarUrl} =
  div []
    [ img [ src avatarUrl ] []
    , h3 [] [ text name ]
    , p [] [ text (toString score) ]
    ]


viewNoSession : Html Msg
viewNoSession =
  div []
    [ h1 [] [ text "Spotify App" ]
    , h2 [] [ text "Yo! Sign in to join the room" ]
    , button [ onClick SignIn ] [ text "Sign in!" ]
    ]
