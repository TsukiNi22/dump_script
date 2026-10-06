#!/bin/bash
# Usage: sudo bash pam_usb/set-file.sh <vendor-id> <device-id>
# Write /etc/security/pam_usb.conf for the given usb (the auth stack is edited by launch.sh)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

VENDOR_ID="${1:?Error: missing vendor-id}"
DEVICE_ID="${2:?Error: missing device-id}"

# =========================
# Usb information
# =========================
# Sysfs folder of the usb (the one whose idVendor / idProduct match)
usb_path=""
for dir in /sys/bus/usb/devices/*; do
    if [[ "$(cat "$dir/idVendor" 2> /dev/null)" == "$VENDOR_ID" \
        && "$(cat "$dir/idProduct" 2> /dev/null)" == "$DEVICE_ID" ]]; then
        usb_path="$dir"
        break
    fi
done
if [[ -z "$usb_path" ]]; then
    failed "Can't access the usb ($VENDOR_ID:$DEVICE_ID)"
    exit 1
fi

model=$(cat "$usb_path/product" 2> /dev/null || echo "Unknown")
vendor=$(cat "$usb_path/manufacturer" 2> /dev/null || echo "Unknown")
serial=$(cat "$usb_path/serial" 2> /dev/null || echo "")
if [[ -z "$serial" ]]; then
    failed "The usb has no serial number (needed by pam usb)"
    exit 1
fi

# Uuid of the first volume of the disk with this serial
disk=$(lsblk -dnrpo NAME,SERIAL | awk -v serial="$serial" '$2 == serial {print $1; exit}')
uuid=""
if [[ -n "$disk" ]]; then
    uuid=$(lsblk -nro UUID "$disk" | grep -m 1 . || true)
fi
if [[ -z "$uuid" ]]; then
    failed "Can't find the volume uuid of the usb (serial: $serial)"
    exit 1
fi

# =========================
# Files
# =========================
tmp_conf=$(mktemp)
trap 'rm -f "$tmp_conf"' EXIT
sed -e "s|VENDOR_NAME|$(escape_sed "$vendor")|g" \
    -e "s|MODEL_NAME|$(escape_sed "$model")|g" \
    -e "s|SERIAL_NUMBER|$(escape_sed "$serial")|g" \
    -e "s|VOLUME_UUID|$(escape_sed "$uuid")|g" \
    -e "s|WHOAMI|$(escape_sed "$SUDO_USER")|g" \
    "$SCRIPT_DIR/pam_usb.conf" > "$tmp_conf"
ok "Set of the pam_usb.conf variables"

install_root_file 644 "$tmp_conf" /etc/security/pam_usb.conf
ok "Pam usb config file setup"
