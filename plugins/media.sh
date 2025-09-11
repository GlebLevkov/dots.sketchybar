#!/bin/bash

sleep 1

STATE="$(media-control get)"

hide() {
  sketchybar --animate sin 30 --set "$NAME" drawing=off
  exit 0
}

if [[ -z "$STATE" ]]; then
  hide
fi

IFS=$'\n' read -d '' -r -a FIELDS <<<"$(echo "$STATE" | jq -r '[.title, .artist, .artworkData, .bundleIdentifier, .playing] | .[]')"

MEDIA_TITLE=${FIELDS[0]}
MEDIA_ARTIST=${FIELDS[1]}
MEDIA_ARTWORK=${FIELDS[2]}
MEDIA_BUNDLE_ID=${FIELDS[3]}
MEDIA_PLAYING=${FIELDS[4]}

if [[ "$MEDIA_BUNDLE_ID" == "app.zen-browser.zen" ]]; then
  hide
fi

if [[ "$MEDIA_PLAYING" != "true" ]] || [[ -z "$MEDIA_TITLE" ]]; then
  hide
fi

LABEL="$MEDIA_TITLE"
if [[ "$MEDIA_ARTIST" != "null" && -n "$MEDIA_ARTIST" ]]; then
  LABEL+=" / $MEDIA_ARTIST"
fi

args=("--set" "$NAME" label="$LABEL")

if [[ -n "$MEDIA_ARTWORK" ]]; then
  COVER_PATH="/tmp/sketchybar-cover"
  echo "$MEDIA_ARTWORK" | base64 --decode >"$COVER_PATH"
  args+=("background.image.string=$COVER_PATH")
fi

sketchybar --animate sin 30 "${args[@]}" drawing=on
