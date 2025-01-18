module Footer exposing (Model, Msg, init, update, view)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Font exposing (center)

type alias Model = 
    { copyright : String
    }

type Msg 
    = NoOp

init : ( Model, Cmd Msg )
init =
    ({ copyright = "|   All rights reserved © 2024  |   Bellr Pty Ltd"}, Cmd.none )
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

view : Model -> Element Msg
view model=
     el
        [ width fill
         ,padding 2
        , Background.color (Element.rgb255 240 240 240)
        --,centerX
        ]
        (footerContent model)

footerContent : Model -> Element msg
footerContent model =
    Element.row
        [ 
         Element.spacing 10
        , alignBottom
       -- , Element.Font.center
        , centerX
        , Font.size 11
        ]
        [
           footerIcon
        ,  text model.copyright
        ]

footerIcon : Element msg
footerIcon =
    Element.image
        [ Element.width (Element.px 22)
        , Element.height (Element.px 22)
        ]
        { src = "../images/bellr icon.svg"
        , description = "Footer Icon"
        }