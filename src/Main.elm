module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)
import Header
import Footer
import Theme

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

type alias Model =
    { headerModel : Header.Model
    , footerModel : Footer.Model
    }

type Msg
    = HeaderMsg Header.Msg
    | FooterMsg Footer.Msg
    | NoOp

init : () -> ( Model, Cmd Msg )
init _ =
    let
        ( headerModel, headerCmd ) =
            Header.init
        
        ( footerModel, footerCmd ) =
            Footer.init
    in
    ( { headerModel = headerModel
      , footerModel = footerModel
      }
    , Cmd.batch
        [ Cmd.map HeaderMsg headerCmd
        , Cmd.map FooterMsg footerCmd
        ]
    )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HeaderMsg headerMsg ->
            let
                ( headerModel, headerCmd ) =
                    Header.update headerMsg model.headerModel
            in
            ( { model | headerModel = headerModel }
            , Cmd.map HeaderMsg headerCmd
            )
        
        FooterMsg footerMsg ->
            let
                ( footerModel, footerCmd ) =
                    Footer.update footerMsg model.footerModel
            in
            ( { model | footerModel = footerModel }
            , Cmd.map FooterMsg footerCmd
            )
        
        NoOp ->
            ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

view : Model -> Html Msg
view model =
    Element.layout 
        [ width fill
        , height fill
        , Background.color Theme.backgroundColor
        ]
        (column 
            [ width fill
            , height fill
            ]
            [ headerView model
            , gridView
            , footerView model
            ]
        )

headerView : Model -> Element Msg
headerView model =
    Element.map HeaderMsg (Header.view model.headerModel)

footerView : Model -> Element Msg
footerView model =
    Element.map FooterMsg (Footer.view model.footerModel)

gridView : Element Msg
gridView =
    wrappedRow 
        [ width fill
        , height fill
        , padding 20
        , spacing 10
        , Background.color (rgb255 240 240 240)
        ]
        (List.map gridCell (List.range 1 25))

gridCell : Int -> Element Msg
gridCell index =
    el 
        [ width (fillPortion 1)
        , height (px 100)
        , Background.color (rgb255 200 200 200)
        , Border.width 1
        , Border.color (rgb255 150 150 150)
        , Font.center
        , Font.color (rgb255 50 50 50)
        ]
        (text (String.fromInt index))