#!/bin/bash

# Use a temp file to remember the state
STATE_FILE="/tmp/waybar-audio-state"

# 0 = all on, 1 = output muted, 2 = mic muted, 3 = both muted
if [[ ! -f "$STATE_FILE" ]]; then
    echo 0 > "$STATE_FILE"
fi

STATE=$(cat "$STATE_FILE")

case $STATE in
    0)
        # Mute speakers
        pactl set-sink-mute @DEFAULT_SINK@ 1
        pactl set-source-mute @DEFAULT_SOURCE@ 0
        echo 1 > "$STATE_FILE"
        ;;
    1)
        # Mute mic
        pactl set-sink-mute @DEFAULT_SINK@ 0
        pactl set-source-mute @DEFAULT_SOURCE@ 1
        echo 2 > "$STATE_FILE"
        ;;
    2)
        # Mute both
        pactl set-sink-mute @DEFAULT_SINK@ 1
        pactl set-source-mute @DEFAULT_SOURCE@ 1
        echo 3 > "$STATE_FILE"
        ;;
    3)
        # Unmute all
        pactl set-sink-mute @DEFAULT_SINK@ 0
        pactl set-source-mute @DEFAULT_SOURCE@ 0
        echo 0 > "$STATE_FILE"
        ;;
esac
