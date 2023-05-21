#!/bin/sh
#
swayidle -w \
	timeout 300 '~/.config/hypr/scripts/lock.sh' \
	timeout 360 'hyprctl dispatch dpms off eDP-1' \
	resume 'hyprctl dispatch dpms on eDP-1' \
	before-sleep '~/.config/hypr/scripts/lock.sh' \
	lock '~/.config/hypr/scripts/lock.sh'
