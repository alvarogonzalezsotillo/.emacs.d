#!/bin/sh

MONITOR=eDP
TOUCHSCREEN="ELAN Touchscreen"
TOUCHPAD="ETPS/2 Elantech Touchpad"

left(){
    xrandr --output $MONITOR --rotate left
    xinput set-prop "$TOUCHSCREEN" --type=float "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
    xinput set-prop "$TOUCHPAD" --type=float "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
}

right(){
    xrandr --output $MONITOR --rotate right
    xinput set-prop "$TOUCHSCREEN" --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
    xinput set-prop "$TOUCHPAD" --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
}



normal(){
    


    xrandr --output $MONITOR --rotate normal
    xinput set-prop "$TOUCHSCREEN" --type=float "Coordinate Transformation Matrix" 0 0 0 0 0 0 0 0 0
    xinput set-prop "$TOUCHPAD" --type=float "Coordinate Transformation Matrix" 0 0 0 0 0 0 0 0 0


}

left

