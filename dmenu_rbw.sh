#!/usr/bin/sh

if command -v clipctl >/dev/null; then
    _clipctl=true
else
    _clipctl=false
fi

if ! command -v xsel >/dev/null; then
    notify-send -u critical -t 5000 "xsel binary not found"
    exit 127
fi

if ! command -v rbw >/dev/null; then
    notify-send -u critical -t 5000 "rbw binary not found"
    exit 127
fi

# sync database
rbw sync
# open dmenu with the list of accounts
entry="$(rbw ls | dmenu -i -fn 'Monospace 10')"
if [ -z "$entry" ]; then
    exit 1
fi
# stop clipmenu
if $_clipctl; then clipctl disable; fi
# copy password to the clipboard
printf "%s" "$(rbw get "$entry")" | xsel -ibn &
xsel_pid=$!
# restart clipmenu
if $_clipctl; then clipctl enable; fi
notify-send -u normal -t 3000 \
    "password stored in the clipboard, available only for 30 seconds"
# kill xsel after 30 seconds
sleep 30
timeout -k 3 2 kill -15 "$xsel_pid" || kill -9 "$xsel_pid"

