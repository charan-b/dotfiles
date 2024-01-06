#!/bin/sh

gen_output() {
    percent="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')"
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | rg -qi muted && muted=true || muted=false
    echo '{"percent": '"$percent"', "muted": '"$muted"'}'
}

get_time_ms() {
    date -u +%s%3N
}

last_time=$(get_time_ms)
gen_output

pactl subscribe | rg --line-buffered "sink" | while read -r _; do
    current_time=$(get_time_ms)
    delta=$((current_time - last_time))
    # 50ms debounce
    if [ $delta -gt 50 ]; then
        gen_output
        # reset debounce timer
        last_time=$(get_time_ms)
    fi
done
