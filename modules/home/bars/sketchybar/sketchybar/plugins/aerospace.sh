#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    # sketchybar --set $NAME background.drawing=on

    sketchybar --animate quadratic 7 \
        --set $NAME icon.font.size=25

        # --set $NAME y_offset=10 \

else
    # sketchybar --set $NAME background.drawing=off
    sketchybar --animate quadratic 7 \
        --set $NAME icon.font.size=15

        # --set $NAME y_offset=0 \
fi
