#!/bin/bash

# Uses dunstify for sending notifications

# Configuration
LOW_BATTERY=20
CRITICAL_BATTERY=10
CHECK_INTERVAL=60  # seconds

# State file to track if notification was already sent
STATE_FILE="/tmp/battery_notified_$$"

# Function to get battery percentage
get_battery_percentage() {
    cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n 1
}

# Function to get battery status (Charging/Discharging/Full)
get_battery_status() {
    cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -n 1
}

# Function to send notification
send_notification() {
    local level=$1
    local percentage=$2
    local urgency=$3
    local icon=$4
    local message=$5

    dunstify -a "Battery Monitor" -u "$urgency" -i "$icon" \
        -h string:x-dunst-stack-tag:battery \
        "Battery ${level}" "$message"
}

# Initialize state
touch "$STATE_FILE"

# Main monitoring loop
while true; do
    battery_percentage=$(get_battery_percentage)
    battery_status=$(get_battery_status)

    # Check if battery info is available
    if [ -z "$battery_percentage" ]; then
        echo "Error: Could not read battery information"
        sleep "$CHECK_INTERVAL"
        continue
    fi

    # Only alert if discharging (not charging)
    if [ "$battery_status" = "Discharging" ]; then

        if [ "$battery_percentage" -le "$CRITICAL_BATTERY" ]; then
            # Critical battery level
            if ! grep -q "critical" "$STATE_FILE"; then
                send_notification "Critical!" "$battery_percentage%" "critical" \
                    "battery-caution" "Battery at ${battery_percentage}%! Plug in your charger immediately!"
                echo "critical" > "$STATE_FILE"
            fi

        elif [ "$battery_percentage" -le "$LOW_BATTERY" ]; then
            # Low battery level
            if ! grep -q "low\|critical" "$STATE_FILE"; then
                send_notification "Low" "$battery_percentage%" "normal" \
                    "battery-low" "Battery at ${battery_percentage}%. Consider plugging in your charger."
                echo "low" > "$STATE_FILE"
            fi
        else
            # Battery is above thresholds, reset state
            > "$STATE_FILE"
        fi
    else
        # Battery is charging or full, reset state
        > "$STATE_FILE"
    fi

    sleep "$CHECK_INTERVAL"
done
