#!/bin/sh

BORG_REPO=/mnt/volume/Doc/home-borg

if [ "$1" = "-c" ]; then
    printf "checking integrity...\n"
    borg check -v $BORG_REPO || exit 1
fi
printf "starting home backup...\n"
borg create -s --progress -C auto,zstd,2 -x \
    -e *.cache* -e *.ccache* -e *.nvm* --exclude-caches \
    "$BORG_REPO::as3ii-{now}" /home/as3ii
printf "home backup ended.\nStart syncing...\n"
sync -f $BORG_REPO
printf "Done!\n"


