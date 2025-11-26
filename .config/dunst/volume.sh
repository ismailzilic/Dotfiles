#!/bin/bash

# Uses wpctl (wireplumber) for PipeWire audio control
# Uses dunstify for sending norifications

# Function to get current volume percentage
get_volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'
}

# Function to check if muted
is_muted() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED"
}

# Function to send notification
send_notification() {
    local volume=$1
    local muted=$2
    local icon=""

    if [ "$muted" = "true" ]; then
        icon="audio-volume-muted-symbolic"
        dunstify -a "Volume" -u low -i "$icon" -h string:x-dunst-stack-tag:volume \
            -h int:value:0 "Volume: Muted"
    else
        # Choose icon based on volume level
        if [ "$volume" -eq 0 ]; then
            icon="audio-volume-muted-symbolic"
        elif [ "$volume" -le 33 ]; then
            icon="audio-volume-low-symbolic"
        elif [ "$volume" -le 66 ]; then
            icon="audio-volume-medium-symbolic"
        else
            icon="audio-volume-high-symbolic"
        fi

        # Send notification with progress bar
        dunstify -a "Volume" -u low -i "$icon" -h string:x-dunst-stack-tag:volume \
            -h int:value:"$volume" "Volume: ${volume}%"
    fi
}

# Main logic
case "$1" in
    up)
        step="${2:-5}"
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ "${step}%+"
        current=$(get_volume)
        send_notification "$current" "false"
        ;;
    down)
        step="${2:-5}"
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ "${step}%-"
        current=$(get_volume)
        send_notification "$current" "false"
        ;;
    set)
        [ -z "$2" ] && echo "Usage: $0 set <percentage>" && exit 1
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ "$2%"
        send_notification "$2" "false"
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        current=$(get_volume)
        if is_muted; then
            send_notification "$current" "true"
        else
            send_notification "$current" "false"
        fi
        ;;
    get)
        get_volume
        ;;
    notify)
        current=$(get_volume)
        if is_muted; then
            send_notification "$current" "true"
        else
            send_notification "$current" "false"
        fi
        ;;
    mic-toggle)
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "MUTED"; then
            dunstify -a "Microphone" -u low -i "microphone-sensitivity-muted-symbolic" \
                -h string:x-dunst-stack-tag:microphone "Microphone: Muted"
        else
            dunstify -a "Microphone" -u low -i "microphone-sensitivity-high-symbolic" \
                -h string:x-dunst-stack-tag:microphone "Microphone: Unmuted"
        fi
        ;;
    *)
        echo "Usage: $0 {up|down|set|mute|mic-toggle|get|notify} [value]"
        echo "  up [step]    - Increase volume (default: 5%)"
        echo "  down [step]  - Decrease volume (default: 5%)"
        echo "  set <value>  - Set volume to specific percentage"
        echo "  mute         - Toggle mute on/off"
        echo "  mic-toggle   - Toggle microphone mute on/off"
        echo "  get          - Get current volume percentage"
        echo "  notify       - Show notification with current volume"
        exit 1
        ;;
esac
