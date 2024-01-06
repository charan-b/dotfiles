#!/bin/sh

if hyprctl workspaces | grep -q "special:$1"; then
	hyprctl dispatch togglespecialworkspace "$1"
else
	hyprctl dispatch exec [ workspace special:"$1" ] kitty "$2"
fi
