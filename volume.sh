#!/bin/sh

amixer scontrols | grep "Master" && name="Master" || name="PCM"

case "$1" in
    up) amixer sset "$name" 5%+ && notify-send -u low -t 500 'volume up';;
    down) amixer sset "$name" 5%- && notify-send -u low -t 500 'volume down';;
    toggle) amixer sset "$name" toggle && notify-send -u low -t 500 'muted/unmuted';;
    *) printf "error: %s not found" "$1"
esac

