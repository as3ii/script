#!/bin/sh

printf "starting home backup...\n"
sources=$(printf "%s" "$(find . -maxdepth 1 -name "*" -not -path "*.cache*" -not -path "." -not -path "*.nvm*" -printf "%f\n")")
for line in $sources; do
    printf "backupping: %s\n" "$line"
    rsync -a -hh --delete --info=stats1 --info=progress2 --modify-window=1 "$line" /mnt/volume/Doc/home-backup
    sleep 1
done
printf "home backup ended.\nStart syncing...\n"
sync -f /mnt/volume/Doc/home-backup
printf "Done!\n"

