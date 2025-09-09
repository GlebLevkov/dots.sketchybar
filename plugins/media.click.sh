#!/bin/bash

DRAWING=$(sketchybar --query "media" | jq -r '.popup.drawing')

if [[ "$DRAWING" == "on" ]]; then
  sketchybar --set media popup.drawing=off --set big_cover drawing=off
else
  COVER_PATH="/tmp/sketchybar-cover"
  sketchybar \
  --set media popup.drawing=on popup.y_offset=3 popup.height=100 \
  --set big_cover drawing=on background.image.string="$COVER_PATH" background.image.corner_radius=5
fi
