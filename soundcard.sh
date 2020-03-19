#!/bin/sh

asoundconf list

printf "type which cart you want to use as default: "
read card
asoundconf set-default-card "$card"
printf "done\n"
