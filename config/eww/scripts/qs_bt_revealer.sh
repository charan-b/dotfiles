#!/bin/bash

bl="$(bluetoothctl devices Paired | cut -d" " -f2-)"
# echo "$bl"

IFS=$'\n'
for line in $bl; do
	btd=",{\"ssid\":\"${line%% *}\", \"dev\":\"${line#* }\"}"
	bt+=$btd
done
echo "[null  $bt ]"
