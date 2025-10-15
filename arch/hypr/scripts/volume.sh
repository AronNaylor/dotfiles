#!/bin/bash

# Icons for notifications
ICON_UP=""
ICON_MUTED=""

# Apply the volume change (without the --limit flag)
wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1"

# Get the current mute status and volume level
MUTE_STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')
VOLUME_LEVEL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')

# Determine which icon and text to display
if [ "$MUTE_STATUS" == "[MUTED]" ]; then
  # Show mute notification with a 2-second timeout
  notify-send -h string:x-canonical-private-synchronous:volume_notif -u low -i "$ICON_MUTED" -t 2000 "Muted"
else
  # Show volume notification with a 2-second timeout
  notify-send -h string:x-canonical-private-synchronous:volume_notif -u low -i "$ICON_UP" -h int:value:"$VOLUME_LEVEL" -t 2000 "Volume: ${VOLUME_LEVEL}%"
fi
