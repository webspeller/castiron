module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html, Attribute)
import Html.Events exposing (on)
import Header
import Footer
import Theme
import Json.Decode as Decode

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
    , botCoords : { x : Int, y : Int }
    }

type Msg
    = HeaderMsg Header.Msg
    | FooterMsg Footer.Msg
    | Move To
    | NoOp

type To
    = Up
    | Down
    | Left
    | Right

onKeyDown : Html.Attribute Msg
onKeyDown =
    on "keydown" keyDecoder

keyDecoder : Decode.Decoder Msg
keyDecoder =
    Decode.field "key" Decode.string
        |> Decode.andThen keyToMsg

keyToMsg : String -> Decode.Decoder Msg
keyToMsg key =
    case key of
        "ArrowLeft" ->
            Decode.succeed (Move Left)

        "ArrowRight" ->
            Decode.succeed (Move Right)

        "ArrowUp" ->
            Decode.succeed (Move Up)

        "ArrowDown" ->
            Decode.succeed (Move Down)

        _ ->
            Decode.fail "Not an arrow key"

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
      , botCoords = { x = 0, y = 0 }
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

        Move direction ->
            let
                updateCoords : To -> { x : Int, y : Int } -> { x : Int, y : Int }
                updateCoords to coords =
                    case to of
                        Up ->
                            { coords | y = coords.y - 1 }

                        Down ->
                            { coords | y = coords.y + 1 }

                        Left ->
                            { coords | x = coords.x - 1 }

                        Right ->
                            { coords | x = coords.x + 1 }

                newCoords =
                    updateCoords direction model.botCoords
            in
            ( { model | botCoords = newCoords }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

view : Model -> Html.Html Msg
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
            , gridView model.botCoords
            , footerView model
            , botView model
            ]
        )

headerView : Model -> Element Msg
headerView model =
    Element.map HeaderMsg (Header.view model.headerModel)

footerView : Model -> Element Msg
footerView model =
    Element.map FooterMsg (Footer.view model.footerModel)

gridView : { x : Int, y : Int } -> Element Msg
gridView botCoords =
    el
    [ width (fillPortion 100)
    , padding 2
    , spacing 1
    , Background.color (rgb255 240 240 240)
    ]
    ( el
        [ centerX
        , centerY
        ]
        (Element.column
        []
        (List.map (gridSet botCoords) (List.range 1 5))
        )
    )

gridSet : { x : Int, y : Int } -> Int -> Element Msg
gridSet botCoords y =
    el
    []
    ( row 
        [ padding 2
        , spacing 1
        , Background.color (rgb255 150 150 150)
        , centerX
        ]
        (List.map (gridCell botCoords y) (List.range 1 5))
    )

gridCell : { x : Int, y : Int } -> Int -> Int -> Element Msg
gridCell botCoords y x =
    let
        txt = 
            if botCoords.x == x && botCoords.y == y then 
                "B" 
            else 
                String.fromInt x ++ ", " ++ String.fromInt y
    in
    el 
        [ width (px 50)
        , height (px 50)
        , Background.color (rgb255 150 150 150)
        , Border.width 1
        , Border.color (rgb255 150 150 150)
        , Font.center
        , Font.color (rgb255 50 50 50)
        ]
        (Element.text txt)

botView : Model -> Element Msg
botView model = 
    el
        [ width (px 300)
        , height (px 300)
        , Background.color (rgb255 0 0 255)
        , Font.color (rgb255 255 255 255)
        , centerX
        , centerY
        ]
        (Element.text ("x: " ++ String.fromInt model.botCoords.x ++ ", y: " ++ String.fromInt model.botCoords.y))