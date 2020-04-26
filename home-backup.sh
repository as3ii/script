#!/bin/sh

printf "starting home backup...\n"
rsync -a --delete -hh --info=stats1 --info=progress2 --modify-window=1 --exclude=.cache --exclude=.ccache --exclude=.nvm /home/as3ii/ /mnt/volume/Doc/home-backup
printf "home backup ended.\nStart syncing...\n"
sync -f /mnt/volume/Doc/home-backup
printf "Done!\n"

