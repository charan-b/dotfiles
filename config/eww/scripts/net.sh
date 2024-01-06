#!/bin/bash
gen_output() {

	state="$(nmcli -t -f device,type,state,connection d status | sed '/loopback\|unavailable/d')"

	wifi=$(echo "${state}" | sed -n '/wifi/p')
	eth=$(echo "${state}" | sed -n '/ethernet/p')

	echo "{\"wifi\": { \"device\": \"${wifi%:wifi*}\" , \"con\": \"${wifi##*:}\"}, \"ethernet\": { \"device\": \"${eth%:ethernet*}\" , \"con\": \"${eth##*:}\"}}"

}

gen_output
nmcli d monitor | rg --line-buffered "connection |: unmanaged" | while read -r _; do
	gen_output
done
