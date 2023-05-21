#!/bin/sh
name="tgpt"
if hyprctl workspaces | grep -q "special:$name"; then
    hyprctl dispatch togglespecialworkspace $name
else
    hyprctl dispatch exec [ workspace special:$name ] kitty
    sleep 0.5
    hyprctl dispatch togglespecialworkspace $name
fi
