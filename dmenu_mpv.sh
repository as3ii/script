#!/bin/sh

link="$(xclip -o -sel clip | dmenu -fn "Monospace 10" -p "Select copyed link: ")"
if [ -n "$link" ]; then
    mpv "$link" >/dev/null 2>&1
    case $? in
        0) return 0;;
        1) notify-send -u critical -t 5000 "MPV Error" "Error initializing mpv";;
        2) notify-send -u critical -t 5000 "MPV Error" "The file passed to mpv couldn't be played";;
        3) notify-send -u critical -t 5000 "MPV Error" "There  were  some files that could be played, and some files which couldn't";;
        4) return 0;;
        *) return $?;;
    esac
fi

