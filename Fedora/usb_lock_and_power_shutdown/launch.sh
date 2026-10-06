#!/bin/bash
# Usage: sudo bash usb_lock_and_power_shutdown/launch.sh [<vendor-id> <device-id> [<cancel-vendor-id> <cancel-device-id>]]
# Lock the session when the usb is removed and/or power off when the charger is unplugged
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

VENDOR_ID="${1:-}"
DEVICE_ID="${2:-}"
CANCEL_VENDOR_ID="${3:-}"
CANCEL_DEVICE_ID="${4:-}"
USB_RULE="/etc/udev/rules.d/80-usb-lock.rules"
POWER_RULE="/etc/udev/rules.d/80-power-shutdown.rules"
DETECTION_SCRIPT="/usr/local/bin/usb-lock_power-shutdown.sh"

install_packages gum usbutils || exit 1

# Action proposed for a rule: Activation when it isn't installed yet
get_status() {
    if [[ -f "$1" ]]; then
        echo "Deactivation"
    else
        echo "Activation"
    fi
}

reload_rules() {
    udevadm control --reload-rules
    ok "Udev rules reloaded"
}

if usb_is_plugged "$VENDOR_ID" "$DEVICE_ID"; then
    CHOICE=$(gum choose \
        "USB Lock ($(get_status "$USB_RULE"))" \
        "Power Shutdown ($(get_status "$POWER_RULE"))" \
        "Both (Activation)" \
        "Both (Deactivation)" \
        "Cancel") || CHOICE="Cancel"
else
    # Without usb only the deactivation of what is installed is possible
    OPTIONS=()
    [[ -f "$USB_RULE" ]] && OPTIONS+=("USB Lock (Deactivation)")
    [[ -f "$POWER_RULE" ]] && OPTIONS+=("Power Shutdown (Deactivation)")
    [[ ${#OPTIONS[@]} -eq 2 ]] && OPTIONS+=("Both (Deactivation)")
    if [[ ${#OPTIONS[@]} -eq 0 ]]; then
        info "Nothing to deactivate (no main usb to activate them)"
        exit 0
    fi
    CHOICE=$(gum choose --header "No main usb: deactivation only" "${OPTIONS[@]}" "Cancel") || CHOICE="Cancel"
fi

# =========================
# Deactivation
# =========================
case "$CHOICE" in
    "Cancel")
        skipped "Usb lock & power shutdown"
        exit 0
        ;;
    "USB Lock (Deactivation)")
        rm -f "$USB_RULE"
        ok "USB Lock rule removed"
        ;;
    "Power Shutdown (Deactivation)")
        rm -f "$POWER_RULE"
        ok "Power Shutdown rule removed"
        ;;
    "Both (Deactivation)")
        rm -f "$USB_RULE" "$POWER_RULE"
        ok "USB Lock & Power Shutdown rules removed"
        ;;
esac
if [[ "$CHOICE" == *"(Deactivation)" ]]; then
    if [[ ! -f "$USB_RULE" && ! -f "$POWER_RULE" ]]; then
        rm -f "$DETECTION_SCRIPT"
        ok "Detection script removed"
    fi
    reload_rules
    exit 0
fi

# =========================
# Activation
# =========================
if ! bash "$SCRIPT_DIR/set-file.sh" "$CANCEL_VENDOR_ID" "$CANCEL_DEVICE_ID"; then
    failed "Setup of the USB & Power detection script"
    exit 1
fi

if [[ "$CHOICE" == "Both (Activation)" || "$CHOICE" == "USB Lock (Activation)" ]]; then
    tmp_rule=$(mktemp)
    trap 'rm -f "$tmp_rule"' EXIT
    sed -e "s|VENDOR_IDV|$(escape_sed "$VENDOR_ID")|g" \
        -e "s|DEVICE_IDV|$(escape_sed "$DEVICE_ID")|g" \
        "$SCRIPT_DIR/80-usb-lock.rules" > "$tmp_rule"
    install_root_file 644 "$tmp_rule" "$USB_RULE"
    ok "USB Lock rule setup"
fi

if [[ "$CHOICE" == "Both (Activation)" || "$CHOICE" == "Power Shutdown (Activation)" ]]; then
    install_root_file 644 "$SCRIPT_DIR/80-power-shutdown.rules" "$POWER_RULE"
    ok "Power Shutdown rule setup"
fi
reload_rules
