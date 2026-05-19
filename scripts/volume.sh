#!/bin/bash

case $1 in
up) wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 1%+ ;;
down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- ;;
mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
esac

VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c MUTED)

if [ "$MUTED" -gt 0 ]; then
  notify-send -h string:x-dunst-stack-tag:volume -h int:value:$VOL "󰝟 Muted"
else
  notify-send -h string:x-dunst-stack-tag:volume -h int:value:$VOL "󰕾 Volume" "$VOL%"
fi
