#!/bin/sh


if command -v clipmenu >/dev/null; then
    link="$(CM_OUTPUT_CLIP=1 clipmenu -fn "Monospace 10" -p "Select copyed link: ")"
else
    link="$(echo "$(xclip -o -sel clip)\n\
        $(find . -L -type f -maxdepth 5 -name "*" ! -path "./.*"\
        ! -path "." -printf "%f\n")"\
        | dmenu -fn "Monospace 10" -p "Select copyed link: ")"
fi

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

