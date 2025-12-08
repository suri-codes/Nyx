#!/usr/bin/env sh
source "$HOME/.config/sketchybar/colors.sh"
sketchybar \
           --add item        mem.used_txt e             \
           --set mem.used_txt label.font="FiraCode Nerd Font:Bold:10"   \
                             label=MEM                     \
                             y_offset=-4                   \
                             width=0                       \
                             icon.drawing=off              \
                             update_freq=2                 \
                             padding_left=15 \
                                                                                        \
           --add graph       mem.used e 80                 \
           --set mem.used    graph.color=$RED             \
                             update_freq=2                 \
                             label.drawing=off             \
                             icon.drawing=off              \
                             background.padding_left=4     \
                             padding_left=15 \
                             script="$PLUGIN_DIR/memory.sh"   \
