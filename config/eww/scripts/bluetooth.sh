#!/bin/sh
#
state="$(bluetoothctl show E8:48:B8:C8:20:00 | awk '/Powered/ {print $2}')"
[ "$state" = "yes" ] && connection="$(bluetoothctl info 2>/dev/null | awk -F ": " '/Name/ {print $2}')"
[ -n "$connection" ] && battery="$(bluetoothctl info 2>/dev/null | grep "Battery" | sed 's/.*(\([0-9]*\))/\1/')"

echo "{\"state\": \"$connection\", \"battery\": ${battery:-0}}"
