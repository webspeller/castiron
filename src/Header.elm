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
    ( { title = "Bellroy Coding Task" }, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

view : Model -> Element Msg
view model =
    el 
        [ width fill
        , padding 10
        , Background.color (rgb255 240 240 240)
        , Font.center
        ]
        (text model.title)