#!/bin/sh

if hyprctl workspaces | grep -q "special:term"; then
    hyprctl dispatch togglespecialworkspace term
else
    hyprctl dispatch exec [ workspace special:term ] kitty
    sleep 0.5
    hyprctl dispatch togglespecialworkspace term
fi
