module Main exposing (main)

import Browser
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Http
import Json.Decode as D


main : Program Bool Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type Rate
    = Loading
    | Failure
    | Success Float


type alias Model =
    { dark : Bool
    , rate : Rate
    }


init : Bool -> ( Model, Cmd Msg )
init dark =
    ( { dark = dark, rate = Loading }
    , Http.get
        { url = "https://api.exchangerate-api.com/v4/latest/USD"
        , expect = Http.expectJson GotRate rateDecoder
        }
    )


rateDecoder : D.Decoder Float
rateDecoder =
    D.field "rates" (D.field "CAD" D.float)



-- UPDATE


type Msg
    = GotRate (Result Http.Error Float)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotRate (Ok rate) ->
            ( { model | rate = Success rate }, Cmd.none )

        GotRate (Err _) ->
            ( { model | rate = Failure }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        ( backgroundColor, textColor ) =
            if model.dark then
                ( "#222", "#fff" )

            else
                ( "#fff", "#222" )

        message =
            case model.rate of
                Loading ->
                    "…"

                Failure ->
                    "Couldn't load the exchange rate."

                Success rate ->
                    "1 USD → " ++ String.fromFloat rate ++ " CAD"
    in
    div
        [ style "height" "100vh"
        , style "display" "flex"
        , style "align-items" "center"
        , style "justify-content" "center"
        , style "font-family" "'Courier New', Courier, monospace"
        , style "background-color" backgroundColor
        , style "color" textColor
        ]
        [ text message ]
