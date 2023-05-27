#!/bin/sh

toggle() {
  wpctl set-mute @DEFAULT_SINK@ toggle
}

icon() {
  if ! wpctl get-volume @DEFAULT_SINK@|grep -q "MUTED" ; then
    vol=$(echo - |awk "{print $(wpctl get-volume @DEFAULT_SINK@|cut -d" " -f2) * 100}")

        if [ "${vol}" -ge 50 ]; then
            echo "􀊧 "
        elif [ "${vol}" -ge 20 ]; then
            echo "􀊥 "
        else
            echo "􀊡"
        fi
  else
        echo "􀊣 "
  fi
}

volume() {
    vol="$(echo - |awk "{print $(wpctl get-volume @DEFAULT_SINK@|cut -d" " -f2) * 100}")"
    echo "$vol"
}

json() {
  echo "{\"volume\": \"$(volume)\", \"icon\": \"$(icon)\"}"
}
case $1 in 
  toggle)
    toggle
    ;;
  icon)
    icon
    ;;
  volume)
    volume
    ;;
  *)
    json
    ;;
esac
