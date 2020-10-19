#!/bin/sh

# check global variable
if [ -z "$BORG_REPO" ]; then
    export BORG_REPO="/mnt/archive/backup"
fi

# check target folders
if [ -z "${BORG_REPO##/home*}" ]; then
    printf "Target folder could not be inside the home directory\n"
    exit 1
fi

# check if the repo exists
if ! [ "$(grep "Borg" "$BORG_REPO/README")" = \
    "This is a Borg Backup repository." ]; then
    borg init -e repokey-blake2 "$BORG_REPO"
fi

# check for 'check' flag
if [ "$1" = "-c" ] || [ "$1" = "--check" ]; then
    printf "Checking integrity...\n"
    ionice -c 3 borg check -v "$BORG_REPO" || exit 1
fi

printf "Starting home backup...\n"
ionice -c 3 borg create -s --progress -C auto,zstd,7 -x \
    -e '/home/*/.cache/ccache' \
    -e '/home/*/.cache/mozilla/firefox/*/cache*' \
    -e '/home/*/.cache/spotify/Data' \
    -e '/home/*/.cache/winetricks' \
    -e '/home/*/.cache/keybase/*log*' \
    -e '/home/*/.cache/wine' \
    -e '/home/*/.cache/calibre' \
    -e '/home/*/.cache/supertuxkart' \
    -e '/home/*/.local/share/Steam' \
    -e '/home/*/.local/share/Trash' \
    -e '/home/*/.local/share/TelegramDesktop' \
    -e '/home/*/.local/share/cargo' \
    -e '/home/*/.nvm' \
    -e '/home/*/.nv' \
    --exclude-caches --show-rc \
    ::'{hostname}-{now}' /home

printf "Pruning repository...\n"
ionice -c 3 borg prune -s --prefix '{hostname}-' \
    --keep-daily 3 --show-rc

printf "Starting sync...\n"
sync -f $BORG_REPO
printf "Done!\n"

