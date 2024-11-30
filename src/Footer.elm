module Footer exposing (Model, Msg, init, update, view)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Font exposing (center)

type alias Model = 
    { copyright : String }

type Msg 
    = NoOp

init : ( Model, Cmd Msg )
init =
    ( { copyright = "© , 2024" }, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

view : Model -> Element Msg
view model =
     el
        [ Element.width fill
        , padding 10
        , Background.color (Element.rgb255 240 240 240)
        , Font.center
        --, centerX
        ]
        (footerContent model)

footerContent : Model -> Element msg
footerContent model =
    Element.row
        [ Element.width fill
        , Element.spacing 10
        , Element.alignBottom
        , Element.Font.center
        ]
        [
           footerIcon
        ,  text model.copyright
        ]

footerIcon : Element msg
footerIcon =
    Element.image
        [ Element.width (Element.px 66)
        , Element.height (Element.px 66)
        , centerX
        ]
        { src = "../images/bellroy icon.svg"
        , description = "Footer Icon"
        }