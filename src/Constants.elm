module Constants exposing (..)


-- API Settings

baseUri : String
baseUri = "https://api.spotify.com/v1"

accessToken : String
accessToken = "BQCZjvXuRQgMB7452yAKFS8gbEH0rxJ840Y9MFO6Sn3MuCqcHpgAr1QDHVYTxJl3TGWIrnB7mywmqv6c7hkAD7nWBFaOjC1wk53Pn2oBid4NhV8yuGyTqYvW991f9rpMh24lM4oydSoDjHBIMy4dC1Xk8kNujZQLeADI"


-- Login Request Params

clientId : String
clientId = "14a1494b85924a0dbc7ab75cd5c766d9"

responseType : String
responseType = "token"
-- responseType = "code"

redirectUri : String
-- redirectUri = "http:localhost:8000/src/redirect.html"
-- redirectUri = "http%2F%2Flocalhost%3A8000%2Foauth2callback"
-- redirectUri = "http%2F%2Flocalhost:8000%2Fpublic%2Fhtml%2FsignInRedirect.html"
-- redirectUri = "http:localhost:8000/public/html/signInRedirect.html"
redirectUri = "http:localhost:8000/public/html/signInRedirect.html"

-- scopes : List String
-- scopes = [ "user-read-private", "user-read-email" ]

state : String
state = "34fFs29kd09" -- TODO Generate Random String Hash

showDialog : Bool
showDialog = False
