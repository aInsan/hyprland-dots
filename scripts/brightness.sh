#!/bin/bash

case $1 in
up) brightnessctl set 2%+ ;;
down) brightnessctl set 2%- ;;
esac

PERCENT=$(brightnessctl get | awk -v max="$(brightnessctl max)" '{printf "%d", ($1/max)*100}')
notify-send -h string:x-dunst-stack-tag:brightness -h int:value:$PERCENT "󰃞 Brightness" "$PERCENT%"
