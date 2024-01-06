#!/usr/bin/env bash

# get initial focused workspace
active_ws=$(hyprctl activeworkspace -j | jaq -r '.id')

declare -A o=([1]=0 [2]=0 [3]=0 [4]=0 [5]=0 [6]=0 [7]=0 [8]=0 [9]=0 [10]=0)

# handle workspace create/destroy
workspace_event() {
    while read -r k; do o[$k]="1"; done < <(hyprctl -j workspaces | jaq -jr '.[] | .id, "\n"')
}

# generate the json for eww
generate() {
    echo -n '{"workspaces": ['

    for i in {1..10}; do
        echo -n ''"$([ "$i" -eq 1 ] || echo ,)" '{"id": '"$i"', "windows": '"${o[$i]}"'}'
    done

    echo '], "active_win": "'"${activewindow}"'", "active_ws": '"$active_ws"'}'
}

# setup

# add workspaces
workspace_event

# screen is not shared by default
activewindow="$(hyprctl activewindow -j | jaq -r '.class')"

generate

# main loop
socat -u UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | rg --line-buffered "workspace|activewindow>>" | while read -r line; do
    case ${line%>>*} in
        "workspace")
            active_ws=${line#*>>}
            ;;
        "createworkspace")
            o[${line#*>>}]=1
            active_ws=${line#*>>}
            ;;
        "destroyworkspace")
            o[${line#*>>}]=0
            ;;
        "activewindow")
            activewindow="$(echo "${line#*>>}" | cut -d ',' -f1)"
            ;;
    esac
    generate
done
