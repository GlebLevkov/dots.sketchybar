#!/bin/bash

STATE="$(media-control get)"

MEDIA_TITLE="$(echo "$STATE" | jq -r '.title')"
MEDIA_AUTHOR="$(echo "$STATE" | jq -r '.artist')"
MEDIA_ARTWORK="$(echo "$STATE" | jq -r '.artworkData')"
MEDIA_BUNDLE_ID="$(echo "$STATE" | jq -r '.bundleIdentifier')"

LABEL=""

if [[ -n "$MEDIA_TITLE" ]]; then
  LABEL="$MEDIA_TITLE"
fi

if [[ "$MEDIA_AUTHOR" != "null" ]]; then
  LABEL="$LABEL / $MEDIA_AUTHOR"
fi

if [[ -n "$MEDIA_ARTWORK" ]]; then
  echo "$MEDIA_ARTWORK" | base64 --decode > /tmp/sketchybar-cover
fi

# Disable media from zen-browser
if [[ "$MEDIA_BUNDLE_ID" == "app.zen-browser.zen" ]]; then 
  STATE=""
fi

if [ -n "$STATE" ]; then
  if [[ -n "$MEDIA_ARTWORK" ]]; then 
    sketchybar --set "$NAME" label="$LABEL" background.image.string="/tmp/sketchybar-cover" drawing=on
  else
    sketchybar --set "$NAME" label="$LABEL" drawing=on
  fi
fi
