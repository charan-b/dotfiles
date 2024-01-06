#!/bin/sh
#
if hyprctl clients | grep -q "title: open.sh"; then
	hyprctl dispatch closewindow title:open.sh
else
	hyprctl dispatch exec "[size 1790 900;float;move 60 40;pin;dimaround;animation slidevert] foot -T open.sh ~/.local/bin/open.sh hyp"
fi
