module Theme exposing
    ( backgroundColor
    , darkGray
    , primary
    , white
    )

import Element exposing (Color, rgb, rgb255, rgba)


backgroundColor : Color
backgroundColor =
    rgb 0.98 0.98 0.98


primary : Color
primary =
    rgb255 200 88 73


white : Color
white =
    rgb 1 1 1


darkGray : Color
darkGray =
    rgb255 51 51 51