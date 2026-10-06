#!/bin/bash
# Usage: sudo bash take_screen_of_intruder/launch.sh [<vendor-id> <device-id>]
# Take a webcam picture when the screen is locked and the usb is unplugged (deactivate it without usb)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

VENDOR_ID="${1:-}"
DEVICE_ID="${2:-}"
SERVICE="usb-capture.service"
BIN_DIR="/usr/local/bin"

install_packages gum fswebcam usbutils || exit 1

deactivate() {
    systemctl disable --now "$SERVICE" 2> /dev/null || true
    rm -f "/etc/systemd/system/$SERVICE" "$BIN_DIR/check-usb-and-capture.sh" "$BIN_DIR/usb-capture-listener.sh"
    systemctl daemon-reload
    ok "Usb-Capture service & scripts removed"
}

CHOICE="Deactivate"
if usb_is_plugged "$VENDOR_ID" "$DEVICE_ID"; then
    CHOICE=$(gum choose "Activate" "Deactivate") || CHOICE="Cancel"
fi
case "$CHOICE" in
    "Activate") ;;
    "Deactivate") deactivate; exit 0 ;;
    *) skipped "Screen of intruder"; exit 0 ;;
esac

if ! bash "$SCRIPT_DIR/set-file.sh" "$VENDOR_ID" "$DEVICE_ID"; then
    failed "Setup of take screen of intruder file"
    exit 1
fi
