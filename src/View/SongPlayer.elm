module View.SongPlayer exposing (render)

import Html exposing (Html, div, img, video, source, h3, h4, text)
import Html.Attributes exposing (width, height, style, src, controls, autoplay, name, type_)

import Types exposing (Track, Image)
import Messages exposing (Msg)
import Utils exposing (getImageUrl)


-- -- Be Stateful!
-- stateful : Signal State
-- stateful = foldp update initialState Keyboard.presses
--
-- -- If we've reached 37.6 seconds into the piece, jump to 0.05.
-- propertiesHandler : Audio.Properties -> Maybe Audio.Action
-- propertiesHandler properties =
--     if properties.currentTime > 37.6 then Just (Audio.Seek 0.05) else Nothing
--
-- -- If the State says we are playing, Play else Pause
-- handleAudio : State -> Audio.Action
-- handleAudio state =
--     if state.playing then Audio.Play
--     else Audio.Pause
--
-- -- Audio Player with Tetris Theme that triggers when the time changes
-- -- The property Handler will loop at the correct time.
-- builder : Signal (Audio.Event, Audio.Properties)
-- builder = Audio.audio { src = "snd/theme.mp3",
--                         triggers = {defaultTriggers | timeupdate = True},
--                         propertiesHandler = propertiesHandler,
--                         actions = map handleAudio stateful }

-- https://p.scdn.co/mp3-preview/f96c611f0ec01e0300f19f9fd1fa16ba162682c9
render : List Track -> Html Msg
render tracks =
  case List.head tracks of
    Nothing ->
      div [] []

    Just song ->
      case song.preview_url of
        Nothing -> div [] []
        Just url ->
          div
            [ style
                [ ("position", "relative")
                , ("text-align", "center")
                , ("margin-left", "340px")
                ]
            ]
            [ renderAlbumCover song.album.images
            , video
                [ controls True
                , autoplay True
                , name "media"
                , style
                  [ ("visibility", "hidden")
                  , ("opacity", "0")
                  , ("position", "absolute")
                  ]
                ]
                [ source
                  [ src url
                  , type_ "audio/mpeg"
                  ] []
                ]
            , h3
                [ style
                    [ ("font-family", "sans-serif")
                    , ("font-weight", "300")
                    , ("font-size", "22px")
                    , ("margin-bottom", "10px")
                    ]
                ] [ text song.name ]
            , h4
                [ style
                    [ ("font-weight", "100")
                    , ("text-transform", "uppercase")
                    , ("font-size", "15px")
                    , ("font-family", "sans-serif")
                    , ("margin", "0")
                    ]
                ] [ text song.album.name ]
            ]


renderAlbumCover : List Image -> Html Msg
renderAlbumCover images =
  let
    imageUrl = getImageUrl images
  in
    if imageUrl == ""
    then div [] []
    else img
      [ src imageUrl
      , style
        [ ("text-align", "center")
        , ("margin", "0 auto")
        , ("display", "inline-block")
        , ("position", "absolute")
        , ("left", "50%")
        , ("transform", "translateX(-50%)")
        , ("width", "300px")
        , ("height", "300px")
        ]
      ] []
