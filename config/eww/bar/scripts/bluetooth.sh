#!/bin/sh
state="$(bluetoothctl show E8:48:B8:C8:20:00 | awk '/Powered/ {print $2}')"
[ "$state" = "yes" ] && connection="$(bluetoothctl info 2>/dev/null | awk -F ": " '/Name/ {print $2}')"
[ -n "$connection" ] && battery="$(bluetoothctl info 2>/dev/null | grep "Battery" | sed 's/.*(\([0-9]*\))/\1/')"

toggle() {
	if [ "$state" = "yes" ]; then
		bluetoothctl power off
		notify-send "Bluetooth" "Bluetooth has been turned off."
	else
		bluetoothctl power on
		notify-send "Bluetooth" "Bluetooth has been turned on."
	fi
}
connection() {
	[ -n "$connection" ] && echo "$connection" || echo "No Connection"
}
icon() {
	[ -n "$connection" ] && echo "􀑛" || echo "􀒝 "
}
battery() {
	if [ "$1" = "percent" ]; then
		[ -n "$connection" ] && echo "$battery%" || echo ""
	else
		if [ -n "$battery" ]; then
			[ "$battery" -le 20 ] && echo "low" || echo "normal"
		fi
	fi
}

json() {
	echo "{\"state\": \"$(connection)\", \"icon\": \"$(icon)\", \"batterylow\": \"$(battery)\", \"battery\": \"$(battery percent)\"}"
}
case $1 in
toggle)
	toggle
	;;
state)
	connection
	;;
icon)
	icon
	;;
battery)
	battery percent
	;;
*)
	json
	;;
esac
