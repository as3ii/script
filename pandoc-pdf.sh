#!/bin/sh

cd "${1%/*}" || exit

pandoc "$1" -H ~/.script/header.tex -f markdown -t pdf --toc -V geometry:margin=0.8in | zathura - &

