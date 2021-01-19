#!/usr/bin/sh

rbw sync
entry="$(rbw ls | dmenu -i -fn 'Monospace 10')"
if command -v clipmenu >/dev/null; then
    clipctl disable
    printf "%s" "$(rbw get "$entry")" | xsel -ibn &
    xsel_pid=$!
    clipctl enable
    notify-send -u normal -t 3000 "password stored in the clipboard, available only for 30 seconds"
    sleep 30
    timeout -k 3 2 kill -15 "$xsel_pid" || kill -9 "$xsel_pid"
else
    notify-send -u critical -t 5000 "clipmenu related binary not found"
fi

