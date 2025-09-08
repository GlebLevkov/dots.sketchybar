#!/bin/bash

STATE="$(media-control get)"

if [[ -z "$STATE" ]]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

IFS=$'\n' read -d '' -r -a FIELDS <<<"$(echo "$STATE" | jq -r '[.title, .artist, .artworkData, .bundleIdentifier, .playing] | .[]')"

MEDIA_TITLE=${FIELDS[0]}
MEDIA_ARTIST=${FIELDS[1]}
MEDIA_ARTWORK=${FIELDS[2]}
MEDIA_BUNDLE_ID=${FIELDS[3]}
MEDIA_PLAYING=${FIELDS[4]}

echo "MEDIA_TITLE $MEDIA_TITLE"
echo "MEDIA_ARTIST $MEDIA_ARTIST"
echo "MEDIA_PLAYING $MEDIA_PLAYING"

if [[ "$MEDIA_BUNDLE_ID" == "app.zen-browser.zen" ]]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

if [[ "$MEDIA_PLAYING" != "true" ]] || [[ -z "$MEDIA_TITLE" ]]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
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

sketchybar "${args[@]}" drawing=on
