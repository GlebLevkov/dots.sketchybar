#!/usr/bin/env zsh

EXT_DIR="$HOME/.config/sketchybar/ext"

mkdir -p $EXT_DIR/bin

swiftc $EXT_DIR/mediaplayer_watcher.swift -o $EXT_DIR/bin/mediaplayer_watcher
