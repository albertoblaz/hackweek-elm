import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random

type alias Model =
  { die1 : Int
  , die2 : Int
  }

type Msg
  = Roll
  | NewFaces [Int]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      -- FAILS HERE....... :(
      (model, Random.generate NewFaces (Random.list (Random.int 1 6) (Random.int 1 6)))

    NewFaces faces ->
      (Model faces, Cmd.none)

view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text "Random die generator" ]
    , p [] [ text (toString model.die1) ]
    , p [] [ text (toString model.die2) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]

init : (Model, Cmd Msg)
init =
  (Model 1 1, Cmd.none)
