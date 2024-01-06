#!/bin/sh

STATUS=$(dunstctl is-paused)

if [ "$STATUS" = "false" ]; then
    dunstctl set-paused true
else
    dunstctl set-paused false
    notify-send --urgency=normal "Do Not Disturb" "Do not Disturb has been turned off!"
fi
