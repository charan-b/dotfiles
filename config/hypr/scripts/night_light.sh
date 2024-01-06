#!/bin/sh

set -x
status="hyprctl getoption decoration:screen_shader -j|gojq '.str'"

if [ "$status" = "[[EMPTY]]" ]; then
	hyprctl keyword decoration:screen_shader "$HOME/.config/hypr/scripts/screenShader.frag"
else
	hyprctl keyword decoration:screen_shader \"[[EMPTY]]\"
fi
