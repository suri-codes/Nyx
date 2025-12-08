sketchybar --add graph net.in e 100 \
           --set net.in icon.drawing=off label.drawing=off graph.color=$BLUE width=0 script="$PLUGIN_DIR/network.sh" \
                             padding_left=15 \
           --add item net.in_txt e \
           --set net.in_txt icon.drawing=off icon.font.size=10 width=0 label="-.--KB/s" label.font.size=10 label.font.style=Bold \
                             padding_left=15 \
           --add item net.out_txt e \
           --set net.out_txt icon.drawing=off icon.font.size=10 width=0 label="-.--KB/s" label.font.size=10 label.font.style=Bold  \
                 y_offset=12 \
                             padding_left=15 \
           --add graph net.out e 100 \
           --set net.out icon.drawing=off label.drawing=off graph.color=$YELLOW padding_left=0 \
                             padding_left=15 \
           --add bracket networks net.out net.in net.in_txt net.out_txt \
           --set networks background.color=0xff000000 padding_left=5 padding_right=5 background.corner_radius=0 background.height=40 \
                             padding_left=15 \
