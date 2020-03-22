#!/bin/sh

eq=$(printf "" | dmenu -fn "Monospace 10" -p "write equation: ")
ret=$(python3 -c "import math; print($eq)")
notify-send -u low -t 5000 "Result" "$ret" 
