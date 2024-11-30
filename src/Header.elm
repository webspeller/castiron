module Header exposing (Model, Msg, init, update, view)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font

type alias Model = 
    { title : String }

type Msg 
    = NoOp

init : ( Model, Cmd Msg )
init = 
    ({ title = "Bellroy Coding Task" }, Cmd.none )

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
        ]
        (headerContent model)

headerContent : Model -> Element msg
headerContent model =
    Element.row
        [ Element.width fill
        , Element.alignBottom
        --, Element.spacing 10
        , Font.center
        ]
        [
           headerIcon
        ,  text model.title
        ]

headerIcon : Element msg
headerIcon =
    Element.image
        [ Element.width (Element.px 66)
        , Element.height (Element.px 66)
        ]
        { src = "../images/bellroy icon red.svg"
        , description = "Header Icon"
        }