#!/bin/sh

if hyprctl workspaces | grep -q "special:$1"; then
	hyprctl dispatch togglespecialworkspace "$1"
else
	hyprctl dispatch exec [ workspace special:"$1" ] kitty
	sleep 0.5
	hyprctl dispatch togglespecialworkspace "$1"
fi
