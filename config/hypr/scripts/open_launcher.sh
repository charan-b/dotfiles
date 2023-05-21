#!/bin/sh
#
if hyprctl clients | grep -q "title: opn"; then
    hyprctl dispatch closewindow title:opn
else
    hyprctl dispatch exec "[size 1790 900;float;move 60 40;pin] kitty ~/.local/bin/opn hyp"
fi
