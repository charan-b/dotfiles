#!/bin/sh

status=$(hyprctl getoption decoration:screen_shader -j | gojq -r '.str')

toggle() {
	if [ "$status" = '[[EMPTY]]' ]; then
		hyprctl keyword decoration:screen_shader "$HOME/dotfiles/config/hypr/scripts/screenShader.frag" >/dev/null
		eww update night_light=On
	else
		hyprctl keyword decoration:screen_shader '[[EMPTY]]' >/dev/null
		eww update night_light=Off
	fi
}

state() {
	if [ "$status" = '[[EMPTY]]' ]; then
		echo "Off"
	else
		echo "On"
	fi
}

$1
