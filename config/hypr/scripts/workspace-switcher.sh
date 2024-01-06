#!/bin/sh

# active="$(hyprctl -j monitors | jq -r '.[].activeWorkspace.id')"
# right() {
# last="$(hyprctl -j workspaces | jq -r '.[]|select(.windows > 0)|.id' | sort -n | tail -1)"
# [ "${active}" -lt "${last}" ] && hyprctl dispatch workspace e+1 || hyprctl dispatch workspace $((last + 1))
# }

# left() {
# first="$(hyprctl workspaces -j | jq -r '[.[].id | select(. > 0)]|sort|.[0]')"
# [ "${active}" -eq "${first}" ] && hyprctl dispatch workspace "$first" || hyprctl dispatch workspace e-1
# }

# $1
# [ "$(hyprctl activewindow)" = "Invalid" ] || hyprctl dispatch workspace +1
[ "$(hyprctl -j monitors | jq -r '.[].activeWorkspace.id')" -lt "$(hyprctl -j clients | jq -rc '.[].workspace.id' | sort -un | tail -1)" ] && hyprctl dispatch workspace e+1

[ "$(hyprctl -j monitors | jq -r '.[].activeWorkspace.id')" -eq "$(hyprctl -j clients | jq -rc '.[].workspace.id' | sort -un | tail -1)" ] && hyprctl dispatch workspace +1
