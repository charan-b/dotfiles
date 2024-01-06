#!/bin/sh

wifi=$(nmcli radio wifi)
[ "$wifi" = "disabled" ] && nmcli radio wifi on

state() {
    device="$(nmcli -t -f DEVICE connection show --active | sed '/^lo$/d' | head -1)"
    if [ "$wifi" = "enabled" ]; then
        [ -n "$device" ] && ssid=$(nmcli -g GENERAL.CONNECTION dev show "$device")
    else
        ssid="off"
    fi
    echo "{\"ssid\":\"$ssid\", \"device\":\"$device\"}"
}
toggle() {
    if [ "$wifi" = "enabled" ]; then
        notify-send "Turning wifi off"
        nmcli radio wifi off
    else
        notify-send "Turning WIFI On..."
        nmcli radio wifi on
    fi
}
ssid() {
    nmcli -f ssid,bssid,in-use d w | sed '1d;/*/d' | tr -s " " | jq -ncR '[inputs | split(" ") | { "SSID": .[0], "BSSID": .[1] }]'
}
connect() {
    nmcli d w connect "$1" >/dev/null 2>&1
    # exit_status="$?"
    case "$?" in
        0)
            eww update qs_rev=""
            notify-send -t 2500 "Connected to:  $2         $1"
            ;;
        4)
            eww update ssid_rev="$2"
            notify-send -t 2500 "Please Enter Password."
            ;;
        *)
            eww update qs_rev=""
            notify-send -t 2500 "Connection Failed"
            ;;
    esac
}

case "$1" in
    connect)
        connect "$2" "$3"
        ;;
    ssid)
        ssid
        ;;
    toggle)
        toggle
        ;;
    state)
        state
        ;;
esac
