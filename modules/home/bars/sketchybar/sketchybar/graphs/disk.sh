
#!/usr/bin/env sh
source "$HOME/.config/sketchybar/colors.sh"
sketchybar \
           --add item        disk.used_txt q \
           --set disk.used_txt label.font="FiraCode Nerd Font:Bold:10"   \
                             label=DISK \
                             y_offset=-4                   \
                             width=0                       \
                             icon.drawing=off              \
                             update_freq=1                 \
                             padding_left=15 \
                                                                                        \
           --add graph       disk.used e 80                 \
           --set disk.used   graph.color=$RED             \
                             update_freq=1                 \
                             label.drawing=off             \
                             icon.drawing=off              \
                             background.padding_left=4     \
                             padding_left=15 \
                             script="$PLUGIN_DIR/disk.sh"   \
