#!/usr/bin/env zsh

SPACE_ID=$(echo "$INFO" | jq -r '."display-1"')

bulk_args=()

update_colors() {
    case $SPACE_ID in
    2|11)
        bulk_args+=("--bar")
        bulk_args+=("color=0x80000000")
        ;;
    *)
        bulk_args+=("--bar")
        bulk_args+=("color=0x40000000")
        ;;
    esac
}

update_space() {
    case $SPACE_ID in
    1)
        ICON=󰅶
        ICON_PADDING_LEFT=7
        ICON_PADDING_RIGHT=7
        ;;
    *)
        ICON=$SPACE_ID
        ICON_PADDING_LEFT=9
        ICON_PADDING_RIGHT=10
        ;;
    esac

    bulk_args+=("--set")
    bulk_args+=("$NAME")
    bulk_args+=("icon=$ICON")
    bulk_args+=("icon.padding_left=$ICON_PADDING_LEFT")
    bulk_args+=("icon.padding_right=$ICON_PADDING_RIGHT")
}

case "$SENDER" in
"mouse.clicked")
    # Reload sketchybar
    sketchybar --remove '/.*/'
    source $HOME/.config/sketchybar/sketchybarrc
    ;;
*)
    update_space
    update_colors

    sketchybar "${bulk_args[@]}"
    ;;
esac
