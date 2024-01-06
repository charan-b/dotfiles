#!/bin/sh

color=$(grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | grep -oE "#"\[0-9a-zA-Z\]{6})

[ -n "$color" ] && wl-copy -o "$color" && notify-send "$color"
