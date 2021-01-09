#!/bin/sh

dpi=$(\
    solaar config mouse dpi| \
    grep "dpi = NamedInt" | \
    sed 's/dpi = NamedInt(//;s/, '\''[0-9]*'\'')//' \
)

case $dpi in
    [0-9][0-9][0-9]|1[0-8][0-9][0-9])
        solaar config mouse dpi 2000 # 0-1899
        notify-send -u low -t 1000 "2000 DPI";;
    19[0-9][0-9]|20[0-9][0-9])
        solaar config mouse dpi 2700 # 1900-2099
        notify-send -u low -t 1000 "2800 DPI";;
    2[1-9][0-9][0-9])
        solaar config mouse dpi 1200 # 2100-2999
        notify-send -u low -t 1000 "1200 DPI";;
    *)  solaar config mouse dpi 2000 # 3000-*
        notify-send -u low -t 1000 "Default to 2000";;
esac

