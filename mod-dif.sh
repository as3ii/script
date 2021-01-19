#!/bin/sh

sort -o ~/.config/modprobed-sorted.db ~/.config/modprobed.db

find /lib/modules/5.*-arch* -name '*.ko*' -printf '%f\n' | \
    sort | sed 's/\.ko//;s/\.\(xz\|gz\|zst\)\{0,1\}//'| sed 's/-/_/g' | \
    diff /dev/stdin ~/.config/modprobed-sorted.db

