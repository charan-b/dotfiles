#!/usr/bin/sh
#

export PATH="$HOME"/.local/share/cargo/bin:"$PATH"
active_ws="$(hyprctl -j activeworkspace | jaq -jr '.id')"
active_win="$(hyprctl -j activewindow | jaq -jr '.class')"

# generate the json for eww
generate() {
    hypr="$(hyprctl -j workspaces | jaq -jrc '[.[] | .id | tostring | {(.): 1}] | add + {"active_ws": "'"$active_ws"'","active_win": "'"$active_win"'"}')"
    echo "$hypr"
}
generate

# main loop
socat -u UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | rg --line-buffered "^workspace|activewindow>>|closewindow>>" | while read -r line; do

    case ${line%>>*} in
        "workspace")
            active_ws=${line#*>>}
            ;;
        "activewindow")
            active_win="$(echo "${line#*>>}" | cut -d ',' -f1)"
            ;;
        "closewindow")
            active_win=""
            ;;
    esac
    generate
done
