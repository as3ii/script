#!/bin/sh

TMPP="/tmp/zathura-preview-$PPID.pdf"
pandoc "$1" -H ~/.script/header.tex -f markdown -t pdf --toc -V geometry:margin=0.8in -o $TMPP
if ! pgrep -f "zathura $TMPP"; then
    (zathura $TMPP && rm $TMPP) &
fi
