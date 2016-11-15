import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http exposing (..)
import Json.Decode as Decode

apiKey : String
apiKey = "dc6zaTOxFJmzC"
apiURL : String
apiURL = "https://api.giphy.com/v1/gifs/random?api_key=" ++ apiKey ++ "&tag="


main =
  Html.program
    { init = init "cats"
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { topic : String
  , gifUrl : String
  , errorMessage: String
  , showInput : Bool
  }


init : String -> (Model, Cmd Msg)
init topic =
  ( Model
    topic
    "waiting.gif"
    ""
    True
  , getRandomGif topic)

defaultTopics : List String
defaultTopics =
  ["dogs", "dolphins", "nicholas cage", "trump"]


-- UPDATE


type Msg
  = FetchGif
  | SelectDefaultTopic String
  | SelectOtherTopic
  | NewTopic String
  | NewGif (Result Http.Error String)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    FetchGif ->
      (model, getRandomGif model.topic)

    SelectDefaultTopic newTopic ->
      ({ model | topic = newTopic }, getRandomGif model.topic)

    SelectOtherTopic ->
      ({ model | showInput = True }, Cmd.none)

    NewTopic newTopic ->
      ({ model | topic = newTopic }, Cmd.none)

    NewGif (Ok newUrl) ->
      ({ model | gifUrl = newUrl, errorMessage = "" }, Cmd.none)

    NewGif (Err err) ->
      ({ model | errorMessage = decodeError err }, Cmd.none)


decodeError : Http.Error -> String
decodeError err =
  case err of
    Timeout ->
      "Time exceeded by the request"
    NetworkError ->
      "Can not connect due to a network error"
    -- UnexpectedPayload error ->
    --   "Unexpected payload found on the request: " ++ error
    -- BadResponse code error ->
    --   "The server returned an error " ++ code ++ ": " ++ error
    _ ->
      "Unexpected error"



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text "Gifs Generator"]
    , h2 [] [ text ("Current topic: " ++ model.topic) ]
    , br [] []
    , img [ src model.gifUrl ] []
    , br [] []
    -- , select [ onChange SelectDefaultTopic ] (viewTopics defaultTopics)
    , viewInput model.showInput
    , button [ onClick FetchGif ] [ text "More Please!" ]
    ]


-- onChange : Msg -> Attribute Msg
-- onChange msg =
--   on "change" (Decode.succeed msg)


-- onChange : Signal.Address a -> Attribute Msg
-- onChange address =
--   on "click" Decode.value (\_ -> Signal.message address ())


viewDefaultTopic : String -> Html Msg
viewDefaultTopic str =
  option [ value str ] [ text str ]


viewTopics : List String -> List (Html Msg)
viewTopics topics =
  List.append
    (List.map viewDefaultTopic topics)
    [ option [ value "other" ] [ text "other" ] ]


viewInput : Bool -> Html Msg
viewInput cond =
  if cond
  then input [ type_ "text", placeholder "e.g. cats", onInput NewTopic ] []
  else div [] []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- HTTP


getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let url = apiURL ++ topic
  in Http.send NewGif (Http.get url decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
  Decode.at ["data", "image_url"] Decode.string
