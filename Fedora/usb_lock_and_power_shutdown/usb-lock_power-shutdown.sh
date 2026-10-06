#!/bin/bash
# Usage: usb-lock_power-shutdown.sh lock|shutdown (run by the udev rules)
# Lock & suspend (usb removed) or power off (charger unplugged), unless the cancel usb is plugged
# (CANCEL_VENDOR_IDV / CANCEL_DEVICE_IDV / WHOAMI are replaced at the installation, empty = no cancel usb)
set -euo pipefail

CANCEL_VENDOR_ID="CANCEL_VENDOR_IDV"
CANCEL_DEVICE_ID="CANCEL_DEVICE_IDV"

if [[ -n "$CANCEL_VENDOR_ID" && -n "$CANCEL_DEVICE_ID" ]] \
    && lsusb -d "$CANCEL_VENDOR_ID:$CANCEL_DEVICE_ID" > /dev/null 2>&1; then
    exit 0
fi

case "${1:-}" in
    lock)
        session=$(loginctl list-sessions --no-legend | awk '$3 == "WHOAMI" && $6 == "user" {print $1; exit}')
        if [[ -n "$session" ]]; then
            loginctl lock-session "$session"
        fi
        systemctl suspend
        ;;
    shutdown)
        systemctl poweroff
        ;;
esac
