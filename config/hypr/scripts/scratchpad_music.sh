#!/bin/sh

if hyprctl workspaces | grep -q "special:term"; then
    hyprctl dispatch togglespecialworkspace music
else
    hyprctl dispatch exec [ workspace special:music ] kitty ncmpcpp
    sleep 0.5
    hyprctl dispatch togglespecialworkspace music
fi
