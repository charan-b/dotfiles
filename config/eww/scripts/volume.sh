#!/bin/sh

vol="$(echo - | awk "{print $(wpctl get-volume @DEFAULT_SINK@ | cut -d" " -f2) * 100}")"
if wpctl get-volume @DEFAULT_SINK@ | grep -q "MUTED"; then
	muted=true
else
	muted=false
fi
echo "{\"value\": \"$vol\", \"muted\": \"$muted\"}"
