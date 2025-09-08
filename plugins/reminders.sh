LABEL="$(reminders show-all --due-date today | awk -F': ' '{print $3}')"

sketchybar --animate tanh 20 --set $NAME drawing=on label="$LABEL"
