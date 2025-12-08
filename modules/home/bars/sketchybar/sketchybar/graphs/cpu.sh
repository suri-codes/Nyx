#!/usr/bin/env sh
source "$HOME/.config/sketchybar/colors.sh"
sketchybar \
           --add item        cpu.percent q             \
           --set cpu.percent label.font="FiraCode Nerd Font:Bold:12"   \
                             label=CPU                     \
                             y_offset=-4                   \
                             width=0                       \
                             icon.drawing=off              \
                             update_freq=2                 \
                                                           \
           --add graph       cpu.sys q 80              \
           --set cpu.sys     width=0                       \
                             graph.color=$RED              \
                             graph.fill_color=$RED         \
                             label.drawing=off             \
                             icon.drawing=off              \
                             background.padding_right=5    \
                                                           \
            --add item cpu.top q \
            --set cpu.top label.font="FiraCode Nerd Font:Medium:7" \
                    label=CPU                     \
                    icon.drawing=off              \
                    y_offset=6                    \
                    background.padding_right=5 \
                    width=0 \
           --add graph       cpu.user q 80             \
           --set cpu.user    graph.color=$BLUE             \
                             update_freq=2                 \
                             label.drawing=off             \
                             icon.drawing=off              \
                             background.padding_left=4    \
                             script="$PLUGIN_DIR/cpu.sh" \
