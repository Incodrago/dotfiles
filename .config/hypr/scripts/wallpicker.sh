#!/bin/bash
# Pick a wallpaper with wofi
WALL=$(ls ~/.config/wallpapers | wofi --dmenu --prompt "Choose wallpaper:")

# Exit if nothing selected
[ -z "$WALL" ] && exit

# Full path
WALLPATH="$HOME/.config/wallpapers/$WALL"

# Set wallpaper with animation
swww img "$WALLPATH" --transition-type any --transition-duration 2

# Generate pywal colors
wal -i "$WALLPATH"

# Reload waybar and swaync to pick up new colors
pkill -SIGUSR2 waybar
swaync-client -R
