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
import Element.Border exposing (widthXY)

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
    el
    [ width (fillPortion 100)
    , padding 2
    , spacing 1
    , Background.color (rgb255 240 240 240)
    ]
    ( el
        [ {- -width (fillPortion 200)widthXY 80 80
       
        padding 2
        , spacing 1
        , Background.color (rgb255 240 240 240) -}
        centerX
        , centerY
        ]
        (Element.column
        []
        [gridSet
        , gridSet
        , gridSet
        , gridSet
        , gridSet]
        )
    )


gridSet : Element Msg
gridSet =
    el
    [ {- widthXY 80 80
    , width fill
    , height fill
     width (fillPortion 100) 
    
    , padding 2
    , spacing 1
    , Background.color (rgb255 240 240 240)
    , centerX -}
    ]
    ( row 
        [  --widthXY 2 2
        --width fill
         --height fill
         padding 2
        , spacing 1
        , Background.color (rgb255 150 150 150)
        , centerX
        ]
        (List.map gridCell (List.range 1 5))
    )

gridCell : Int -> Element Msg
gridCell index =
    el 
        [ widthXY 8 8
        , height fill
        , Background.color (rgb255 150 150 150)
        , Border.width 50
        , Border.color (rgb255 150 150 150)
        , Font.center
        , Font.color (rgb255 50 50 50)
        ]
        (text (String.fromInt index))