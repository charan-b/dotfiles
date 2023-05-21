#!/bin/sh

__color="$(hyprpicker -n)"

[ -n "$__color" ] && wl-copy "$__color" && notify-send "$__color"
