#!/bin/sh

# find right mixer control to use
name="$(amixer scontrols | sed "s/^.* '//;s/',[0-9]$//;/.*[Mm]ic.*/d;q")"

case "$1" in
    up) amixer -M sset "$name" 5%+ && notify-send -u low -t 500 'volume up';;
    down) amixer -M sset "$name" 5%- && notify-send -u low -t 500 'volume down';;
    toggle) amixer sset "$name" toggle && notify-send -u low -t 500 'muted/unmuted';;
    *) printf "error: %s not found" "$1"
esac

