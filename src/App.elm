module App exposing (main)

import Navigation
import Messages
import State
import View


main =
  -- Html.program
  Navigation.program Messages.UrlChange
    { init = State.init
    , update = State.update
    , subscriptions = State.subscriptions
    , view = View.render
    }
