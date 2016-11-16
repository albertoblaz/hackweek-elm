import Html exposing (..)
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second, minute, hour)
import Tuple


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { time : Time
  , isPaused : Bool
  }


init : (Model, Cmd Msg)
init =
  ( Model
    0
    False
  , Cmd.none)



-- UPDATE


type Msg
  = Tick Time
  | Pause
  | Resume


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ({ model | time = newTime }, Cmd.none)
    Pause ->
      ({ model | isPaused = True }, Cmd.none)
    Resume ->
      ({ model | isPaused = False }, Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  if model.isPaused
  then Sub.none
  else Time.every second Tick



-- VIEW


view : Model -> Html Msg
view model =
  let
    secs = Time.inMinutes model.time
    mins = Time.inHours model.time
    hours = (Time.inHours model.time) / 60

    viewAnalogClock =
      svg [ viewBox "0 0 100 100", width "300px" ]
        [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
        , viewHand secs "#a70000"  -- seconds
        , viewHand mins "#f7ba33"  -- minutes
        , viewHand hours "#000000"  -- hours
        ]


    viewDigitalClock =
      div []
        [ Html.text (toString hours)
        , Html.text ":"
        , Html.text (toString mins)
        , Html.text ":"
        , Html.text (toString secs)
        ]

    viewButton =
      if model.isPaused
      then button [ onClick Resume ] [ Html.text "Resume" ]
      else button [ onClick Pause ] [ Html.text "Pause" ]
  in
    div []
      [ viewAnalogClock
      , viewDigitalClock
      , viewButton
      ]


getHandCoords : Float -> (Float, Float)
getHandCoords time =
  let
    angle = turns time
    handX = 50 + 40 * cos angle
    handY = 50 + 40 * sin angle
  in
    (handX, handY)


viewHand : Float -> String -> Svg Msg
viewHand time strokeColor =
  let
    hands = getHandCoords time
    strX2 = toString (Tuple.first hands)
    strY2 = toString (Tuple.second hands)
  in
    line
      [ x1 "50"
      , y1 "50"
      , x2 strX2
      , y2 strY2
      , stroke strokeColor
      ] []


-- viewHand : Float -> String -> (String, String)
-- viewHand time strokeColor =
--   let
--     angle = turns time
--     handX = toString (50 + 40 * cos angle)
--     handY = toString (50 + 40 * sin angle)
--   in
--     line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke strokeColor ] []
