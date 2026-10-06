#!/bin/bash
# Usage: sudo bash usb_lock_and_power_shutdown/set-file.sh [<cancel-vendor-id> <cancel-device-id>]
# Install the detection script run by the udev rules
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

CANCEL_VENDOR_ID="${1:-}"
CANCEL_DEVICE_ID="${2:-}"
DETECTION_SCRIPT="/usr/local/bin/usb-lock_power-shutdown.sh"

if [[ -z "$CANCEL_VENDOR_ID" || -z "$CANCEL_DEVICE_ID" ]]; then
    CANCEL_VENDOR_ID=""
    CANCEL_DEVICE_ID=""
    warning "No cancel usb: the lock & shutdown can't be cancelled"
fi

tmp_file=$(mktemp)
trap 'rm -f "$tmp_file"' EXIT
sed -e "s|CANCEL_VENDOR_IDV|$(escape_sed "$CANCEL_VENDOR_ID")|g" \
    -e "s|CANCEL_DEVICE_IDV|$(escape_sed "$CANCEL_DEVICE_ID")|g" \
    -e "s|WHOAMI|$(escape_sed "$SUDO_USER")|g" \
    "$SCRIPT_DIR/usb-lock_power-shutdown.sh" > "$tmp_file"
install_root_file 755 "$tmp_file" "$DETECTION_SCRIPT"
ok "Detection script setup"
