#!/bin/sh

nmcli d w connect "$1" &>/dev/null
if [ $? -eq '0' ]; then
  eww -c ~/.config/eww/wifi_widget close wifi_widget
  notify-send -t 2500 "Connected to:  $2         $1"
else
  eww -c ~/.config/eww/wifi_widget close wifi_widget
  notify-send -t 2500 "Connection Failed"
fi
