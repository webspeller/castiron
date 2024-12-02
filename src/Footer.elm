module Footer exposing (Model, Msg, init, update, view)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Font exposing (center)

type alias Model = 
    { copyright : String
     , year : Int
    }

type Msg 
    = NoOp

init : ( Model, Cmd Msg )
init =
    ({ copyright = "©", year = 2024 }, Cmd.none )
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

view : Model -> Element Msg
view model =
     el
        [ width fill
         ,padding 10
        , Background.color (Element.rgb255 240 240 240)
        --,centerX
        ]
        (footerContent model)

footerContent : Model -> Element msg
footerContent model =
    Element.row
        [ 
         Element.spacing 10
        , Element.alignBottom
        , Element.Font.center
        ,centerX
        , Font.size 11
        ]
        [
           footerIcon
        ,  text model.copyright
        , text model.footerYear
        ]
footerYear: Element msg
footerYear  =
    Element.row
        [width (fillPortion 100) 
         ,  Element.spacing 10
        , Element.alignBottom
        , Element.Font.center
        , Font.size 11
        ]
        [
            text (String.fromInt (model.year))
        ]
footerIcon : Element msg
footerIcon =
    Element.image
        [ Element.width (Element.px 66)
        , Element.height (Element.px 66)
        ]
        { src = "../images/bellroy icon.svg"
        , description = "Footer Icon"
        }