#!/bin/sh

wifi=$(nmcli radio wifi)

[ "$wifi" = "disabled" ] && nmcli radio wifi on
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --color=gutter:-1"

state() {
	if [ "$wifi" = "enabled" ]; then
		ssid=$(nmcli -g NAME connection show --active | sed '/^lo$/d')
		[ -n "$(nmcli -g NAME connection show --active | sed '/^lo$/d')" ] && echo "$ssid" || echo "on"
	else
		echo "off"
	fi
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

connect() {
	con="$(nmcli -f ssid,bssid,in-use d w | grep -v "\*" | fzf --with-nth=1 --header-lines=1 | awk '{print $2}')"
	[ -n "$con" ] && nmcli d w c "$con"
}

$1
