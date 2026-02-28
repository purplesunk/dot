#!/usr/bin/env sh
HYPRNOGAPSMODE=$(hyprctl getoption general:gaps_in | awk 'NR==1{print $3}')
if [ "$HYPRNOGAPSMODE" -gt 0 ] ; then
    hyprctl --batch "\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:rounding 0"
    exit
fi
hyprctl reload
