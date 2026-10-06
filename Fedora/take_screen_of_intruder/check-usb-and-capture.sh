#!/bin/bash
# Take a webcam picture when the screen of WHOAMI is locked and the usb is unplugged
# (VENDOR_IDV / DEVICE_IDV / WHOAMI / USER_HOME / MAX_PICTURESV are replaced at the installation)
set -euo pipefail

VENDOR_ID="VENDOR_IDV"
DEVICE_ID="DEVICE_IDV"
OUTPUT_DIR="USER_HOME/Images/Intruder_Picture"
MAX_PICTURES="MAX_PICTURESV" # 0 = unlimited, else the oldest pictures are deleted
PHOTO_NAME="$OUTPUT_DIR/intruder_$(date +"%Y-%m-%d_%H-%M-%S").jpg"

session=$(loginctl list-sessions --no-legend | awk '$3 == "WHOAMI" && $6 == "user" {print $1; exit}')
if [[ -z "$session" ]]; then
    exit 0
fi
screen_locked=$(loginctl show-session "$session" -p LockedHint --value)

if [[ "$screen_locked" == "yes" ]] && ! lsusb -d "$VENDOR_ID:$DEVICE_ID" > /dev/null 2>&1; then
    mkdir -p "$OUTPUT_DIR"
    fswebcam -q -r 1280x720 --jpeg 85 -D 1 "$PHOTO_NAME"
    # The names hold the date -> sorted by name = from the oldest
    if [[ "$MAX_PICTURES" -gt 0 ]]; then
        find "$OUTPUT_DIR" -maxdepth 1 -name 'intruder_*.jpg' | sort | head -n -"$MAX_PICTURES" | xargs -r rm -f
    fi
fi
exit 0
