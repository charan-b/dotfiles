#!/bin/bash
sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
[ -f /usr/lib/xdg-desktop-portal-hyprland ] && /usr/lib/xdg-desktop-portal-hyprland &
[ -f /usr/lib/xdg-desktop-portal-wlr ] && /usr/lib/xdg-desktop-portal-wlr &
sleep 1
/usr/lib/xdg-desktop-portal &
