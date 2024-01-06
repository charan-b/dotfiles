#!/bin/sh
#
swayidle -w \
    timeout 300 'gtklock -d' \
    timeout 360 'hyprctl dispatch dpms off eDP-1' \
    resume 'hyprctl dispatch dpms on eDP-1' \
    before-sleep 'gtklock -d' \
    lock 'gtklock -d'
