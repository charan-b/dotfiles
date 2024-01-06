#!/bin/sh
#

gen_output() {
	# powered=$(bluetoothctl show | rg Powered | cut -f 2- -d ' ')
	status=$(bluetoothctl info)
	name=$(echo "$status" | rg Name | cut -f 2- -d ' ')
	powered="$(rfkill -J | jaq -r '.rfkilldevices[]|select(.type == "bluetooth").soft')"
	battery="$(echo "$status" | rg "Battery" | sed 's/.*(\([0-9]*\))/\1/')"

	echo '{ "battery": '"${battery:-null}"', "state": "'"$name"'", "powered": "'"${powered}"'" }'
}
get_time_ms() {
	date -u +%s%3N
}
gen_output
last_time=$(get_time_ms)

udevadm monitor | while read -r _; do
	current_time=$(get_time_ms)
	delta=$((current_time - last_time))
	# 50ms debounce
	if [ $delta -gt 50 ]; then
		gen_output
		# reset debounce timer
		last_time=$(get_time_ms)
	fi
done
