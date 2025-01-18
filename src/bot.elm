module Bot exposing (bot)

import Browser
import Browser.Events as Events
import Html exposing (Html, button, div, text)
import Html.Attributes as Attr
import Html.Events exposing (keyCode, on)
import Json.Decode as Decode


type alias Model =
    { botCoords : { x : Int, y : Int } }


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
    let
        _ =
            Debug.log "key" key
    in
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


initialModel : Model
initialModel =
    { botCoords = { x = 0, y = 0 } }


type Msg
    = Move To


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        updateCoords : To -> { x : Int, y : Int } -> { x : Int, y : Int }
        updateCoords direction coords =
            case direction of
                Up ->
                    { coords | y = coords.y - 1 }

                Down ->
                    { coords | y = coords.y + 1 }

                Left ->
                    { coords | x = coords.x - 1 }

                Right ->
                    { coords | x = coords.x + 1 }
    in
    case msg of
        Move direction ->
            let
                newCoords =
                    updateCoords direction model.botCoords
            in
            ( { model | botCoords = newCoords }, Cmd.none )


view : Model -> Html Msg
view model =
    div
        [ Attr.style "width" "300px"
        , Attr.style "height" "300px"
        , Attr.style "background-color" "blue"
        , Attr.style "color" "white"
        , Attr.style "display" "flex"
        , Attr.style "justify-content" "center"
        , Attr.style "align-items" "center"
        ]
        [ text ("x: " ++ String.fromInt model.botCoords.x ++ ", y: " ++ String.fromInt model.botCoords.y) ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    Events.onKeyDown keyDecoder


bot : Program () Model Msg
bot =
    Browser.element
        { init = \_ -> ( initialModel, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
