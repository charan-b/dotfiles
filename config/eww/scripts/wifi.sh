#!/bin/sh

wifi=$(nmcli radio wifi)

[ "$wifi" = "disabled" ] && nmcli radio wifi on

state() {
	device="$(nmcli -t -f DEVICE connection show --active | grep "wlo1")"
	[ -z "$device" ] && device="$(nmcli -t -f DEVICE connection show --active | sed '/^lo$/d')"
	if [ "$wifi" = "enabled" ]; then
		[ -n "$device" ] && ssid=$(nmcli -g GENERAL.CONNECTION dev show "$device")
		[ -n "$ssid" ] || ssid=""
	else
		ssid="off"
	fi
	echo "{\"ssid\":\"$ssid\", \"device\":\"$device\"}"
}
toggle() {
	if [ "$wifi" = "enabled" ]; then
		notify-send "Turning wifi off"
		nmcli radio wifi off
	else
		notify-send "Turning WIFI On..."
		nmcli radio wifi on
	fi
}
ssid() {
	nmcli -f ssid,bssid,in-use d w | sed '1d;/*/d' | tr -s " " | jq -ncR '[inputs | split(" ") | { "SSID": .[0], "BSSID": .[1] }]'
}
connect() {
	if nmcli d w connect "$1" >/dev/null 2>&1; then
		eww -c ~/.config/eww/wifi_widget close wifi_widget
		notify-send -t 2500 "Connected to:  $2         $1"
	else
		eww -c ~/.config/eww/wifi_widget close wifi_widget
		notify-send -t 2500 "Connection Failed"
	fi
}

case "$1" in
connect)
	connect "$2" "$3"
	;;
ssid)
	ssid
	;;
toggle)
	toggle
	;;
state)
	state
	;;
esac
