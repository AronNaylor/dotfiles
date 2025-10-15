#!/bin/bash

# You can customize the icon here
icon="󰃠"

# The brightnessctl command to execute
brightnessctl set "$1"

# Get the new brightness level
brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
brightness_percent=$((brightness * 100 / max_brightness))

# Show the icon and a progress bar with a 2-second timeout
notify-send -h string:x-canonical-private-synchronous:brightness_notif -u low -i "$icon" -h int:value:"$brightness_percent" -t 2000 "Brightness: ${brightness_percent}%"
