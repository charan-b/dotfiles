#!/bin/sh

eww_status=$(eww get player)

mpd() {
	status=$(mpc | awk -F'[][]' 'NF > 1 {print $2}')
	if [ -n "$status" ]; then
		title=$(mpc -f %title% | head -1)
		album=$(mpc -f %album% | head -1)
		[ "$status" = "playing" ] && status="Playing" || status="Paused"
	# else
	# 	title="Nothing is Playing"
	# 	album="No album"
	fi

	echo "{\"status\":\"$status\",\"title\":\"$title\",\"album\":\"$album\"}"
}

mpris() {
	status=$(playerctl status 2>/dev/null)
	if [ -n "$status" ]; then
		title=$(playerctl metadata --format=\{\{title\}\})
		album="$(playerctl metadata --format=\{\{album\}\})"
		artist="$(playerctl metadata --format=\{\{artist\}\})"
	# else
	# 	title="Nothing is Playing"
	# 	album="No albumm"
	# 	artist="No artist"
	fi

	echo "{ \"status\": \"$status\", \"title\": \"$title\", \"album\": \"$album\", \"artist\": \"$artist\"}"
}

toggle() {
	if [ "$(eww get player)" = "mpd" ]; then
		mpc stop
		eww update player=mpris
		notify-send "stopping mpd"
	else
		playerctl stop
		eww update player=mpd
		# echo mpris
		notify-send "stopping mpris"
	fi
}

case "$1" in
toggle)
	toggle
	;;
*)
	[ "$eww_status" = "mpd" ] && mpd || mpris
	;;
esac
