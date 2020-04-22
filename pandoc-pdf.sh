#!/bin/sh

TMPP="/tmp/zathura-preview-$PPID.pdf"

EXPORT=""

if [ "$1" = "--export" ] || [ "$1" = "-e" ]; then
	shift
	if [ -n "$2" ]; then
		EXPORT="$1"
		shift
	else
		printf "Usage: %s [-e filename.pdf] file.md [file2.md [...]]" "$0"
		exit 1
	fi
fi

pandoc "$@" -H ~/.script/header.tex -f markdown -t pdf --toc -V geometry:margin=0.8in -o $TMPP

if [ -n "$EXPORT" ]; then
	cp "$TMPP" "$EXPORT"
fi

if ! pgrep -f "zathura $TMPP"; then
    (zathura $TMPP && rm $TMPP) &
fi
