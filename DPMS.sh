#!/bin/sh

revert() {
    xset dpms 0 0 0
}
trap revert HUP INT TERM
xset +dpms dpms 5 5 5
/home/as3ii/.script/i3lock-multimonitor/lock -i /home/as3ii/Pictures/SteamPunk/IMG_534952.png 
revert
