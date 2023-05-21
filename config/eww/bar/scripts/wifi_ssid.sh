#!/bin/sh

nmcli -f ssid,bssid,in-use d w|sed '1d;/*/d'|tr -s " "| jq -ncR '[inputs | split(" ") | { "SSID": .[0], "BSSID": .[1] }]'

