#!/bin/sh
#

gen_output() {
    percent="$(($(brightnessctl get) * 100 / 120000))"
    echo "$percent"
}

get_time_ms() {
    date -u +%s%3N
}

last_time=$(get_time_ms)
gen_output

udevadm monitor | rg --line-buffered "backlight" | while read -r _; do
    current_time=$(get_time_ms)
    delta=$((current_time - last_time))
    if [ $delta -gt 20 ]; then
        gen_output
        # reset debounce timer
        last_time=$(get_time_ms)
    fi
done
