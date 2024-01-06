#!/bin/sh
#
#
eww state 2>/dev/null || eww daemon

if eww active-windows | grep -q "bar"; then
	hyprctl keyword monitor eDP-1,addreserved,15,15,15,15
	eww close bar && eww open timedate
else
	hyprctl keyword monitor eDP-1,addreserved,45,15,15,15
	eww open bar && eww close timedate 2>/dev/null
fi
# eww open-many --toggle bar timedate
