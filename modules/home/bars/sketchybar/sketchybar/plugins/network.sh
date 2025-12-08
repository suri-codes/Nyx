#!/usr/bin/env sh
source "$HOME/.config/sketchybar/colors.sh"

ifstat -i en0 | while read -r IN_KB OUT_KB; do
    if [[ $IN_KB == "KB/s" ]] || [[ $IN_KB == "en0" ]]; then
        sketchybar --push net.in 0 \
                   --push net.out 0
        continue;
    fi

    if [[ $IN_KB == "0.00" ]]; then
       sketchybar --push net.in 0 \
                  --set net.in_txt label="0.00KB/s " label.color=$BLUE icon.color=$BLUE
    else
        IN=$(echo "l(5 + $IN_KB)/21" | bc -l)
        sketchybar --push net.in $IN \
                   --set net.in_txt label="${IN_KB}KB/s " label.color=$BLUE icon.color=$BLUE
    fi
    if [[ $OUT_KB == "0.00" ]]; then
        sketchybar --push net.out 0 \
                   --set net.out_txt label="0.00KB/s " label.color=$YELLOW icon.color=$YELLOW
    else
        OUT=$(echo "l(5 + $OUT_KB)/21" | bc -l)
        sketchybar --push net.out $OUT \
        --set net.out_txt label="${OUT_KB}KB/s " label.color=$YELLOW icon.color=$YELLOW

    fi
done
