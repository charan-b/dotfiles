#!/bin/sh

if wl-paste | grep -qP '^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.be)\/.+[=\/]?([a-zA-Z0-9_-]*)?$'; then
    notify-send "please wait Video is Loading.."
    mpv --no-terminal --quiet "$(wl-paste)"
    exit 0
else
    notify-send "\"$(wl-paste)\" is Not a Link"
fi
