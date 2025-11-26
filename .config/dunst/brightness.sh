#!/bin/bash

# Uses dunstify for sending notifications

# Function to get current brightness percentage
get_brightness() {
    brightnessctl -m | cut -d, -f4 | tr -d '%'
}

# Function to send notification
send_notification() {
    local brightness=$1
    local icon=""

    # Choose icon based on brightness level
    if [ "$brightness" -le 33 ]; then
        icon="display-brightness-low-symbolic"
    elif [ "$brightness" -le 66 ]; then
        icon="display-brightness-medium-symbolic"
    else
        icon="display-brightness-high-symbolic"
    fi

    # Send notification with progress bar
    dunstify -a "Brightness" -u low -i "$icon" -h string:x-dunst-stack-tag:brightness \
        -h int:value:"$brightness" "Brightness: ${brightness}%"
}

# Main logic
case "$1" in
    up)
        step="${2:-5}"
        brightnessctl set "${step}%+" -q
        current=$(get_brightness)
        send_notification "$current"
        ;;
    down)
        step="${2:-5}"
        brightnessctl set "${step}%-" -q
        current=$(get_brightness)
        send_notification "$current"
        ;;
    set)
        [ -z "$2" ] && echo "Usage: $0 set <percentage>" && exit 1
        brightnessctl set "$2%" -q
        send_notification "$2"
        ;;
    get)
        get_brightness
        ;;
    notify)
        current=$(get_brightness)
        send_notification "$current"
        ;;
    *)
        echo "Usage: $0 {up|down|set|get|notify} [value]"
        echo "  up [step]    - Increase brightness (default: 5%)"
        echo "  down [step]  - Decrease brightness (default: 5%)"
        echo "  set <value>  - Set brightness to specific percentage"
        echo "  get          - Get current brightness percentage"
        echo "  notify       - Show notification with current brightness"
        exit 1
        ;;
esac
