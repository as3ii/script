#!/bin/sh

TMPP="/tmp/zathura-preview-$PPID.pdf"
if [ -f $TMPP ]; then
	kill "$(cat $TMPP)" 2>/dev/null
	rm $TMPP
fi
pandoc "$1" -H ~/.script/header.tex -f markdown -t pdf --toc -V geometry:margin=0.8in | zathura - &
PID=$!
printf "%s" "$PID" > $TMPP

