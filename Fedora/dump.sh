#!/bin/bash
# Usage: sudo bash dump.sh
# Interactive menu running the setups of this folder (each one in <setup>/launch.sh)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

# =========================
# Verification
# =========================
section "VERIFICATION"
ok "Script run as root (user: $SUDO_USER)"
if ! grep -q "^ID=fedora" /etc/os-release; then
    failed "This script must be run on Fedora"
    exit 1
fi
ok "Script run on Fedora"
warning "Proceed with caution"

# =========================
# Update
# =========================
section "UPDATE"
box_open "UPDATE-PACKAGE"
if ! dnf update -y; then
    box_close "UPDATE-PACKAGE"
    failed "Update package"
    exit 1
fi
box_close "UPDATE-PACKAGE"
ok "Update package"

section "INITIALISATION"
install_packages gum usbutils

# =========================
# Usb selection
# =========================
# Ask a usb with gum, print "<vendor-id> <device-id>" (empty when none)
select_usb() {
    local header="$1"
    local choices
    local selected
    local vendor_id=""
    local device_id=""

    choices=$(lsusb | awk '{print $6 " - " substr($0, index($0, $7))}')
    selected=$(printf '%s\nManual\nNone\n' "$choices" | gum choose --height=15 --header "$header") || true
    case "$selected" in
        "Manual")
            vendor_id=$(gum input --placeholder "Write the usb vendor-id")
            device_id=$(gum input --placeholder "Write the usb device-id")
            ;;
        "None"|"")
            ;;
        *)
            vendor_id=$(echo "$selected" | cut -d' ' -f1 | cut -d: -f1)
            device_id=$(echo "$selected" | cut -d' ' -f1 | cut -d: -f2)
            ;;
    esac
    echo "$vendor_id $device_id"
}

# Print the state of the selected usb
check_usb() {
    local name="$1"
    local vendor_id="$2"
    local device_id="$3"

    if [[ -z "$vendor_id" || -z "$device_id" ]]; then
        info "The $name usb is not set"
    elif ! usb_is_plugged "$vendor_id" "$device_id"; then
        failed "Can't find a usb with the given vendor-id and device-id ($vendor_id:$device_id)"
    else
        ok "The $name usb has been found ($vendor_id:$device_id)"
    fi
}

section "USB-SETUP"
read -r vendor_id device_id <<< "$(select_usb "Choose the main usb (optional but recommended):")" || true
check_usb "main" "${vendor_id:-}" "${device_id:-}"
read -r cancel_vendor_id cancel_device_id <<< "$(select_usb "Choose the cancel usb (optional):")" || true
check_usb "cancel" "${cancel_vendor_id:-}" "${cancel_device_id:-}"
vendor_id="${vendor_id:-}"
device_id="${device_id:-}"
cancel_vendor_id="${cancel_vendor_id:-}"
cancel_device_id="${cancel_device_id:-}"

# =========================
# Menu
# =========================
# Run a setup and stop everything if it failed
run_setup() {
    local name="$1"
    shift

    section "$name"
    if ! bash "$@"; then
        failed "$name"
        exit 1
    fi
}

USB_STATE=""
if ! usb_is_plugged "$vendor_id" "$device_id"; then
    USB_STATE=" (Deactivation)"
fi
MENU=("Pam Usb$USB_STATE"
    "Usb Lock & Power Shutdown$USB_STATE"
    "Screen Of Intruder$USB_STATE"
    "Dotfile"
    "Package & App"
    "Git"
    "Grub & Plymouth"
    "Quit")

while true; do
    CHOICE=$(gum choose --cursor "👉" --header "Setup Menu:" "${MENU[@]}") || CHOICE="Quit"

    case "$CHOICE" in
        "Pam Usb"*)
            run_setup "PAM-USB" "$SCRIPT_DIR/pam_usb/launch.sh" "$vendor_id" "$device_id" ;;
        "Usb Lock & Power Shutdown"*)
            run_setup "USB_LOCK-POWER_SHUTDOWN" "$SCRIPT_DIR/usb_lock_and_power_shutdown/launch.sh" \
                "$vendor_id" "$device_id" "$cancel_vendor_id" "$cancel_device_id" ;;
        "Screen Of Intruder"*)
            run_setup "TAKE-SCREEN-OF-INTRUDER" "$SCRIPT_DIR/take_screen_of_intruder/launch.sh" "$vendor_id" "$device_id" ;;
        "Dotfile")
            run_setup "DOTFILE" "$SCRIPT_DIR/dotfile/launch.sh" ;;
        "Package & App")
            run_setup "PACKAGE-APP" "$SCRIPT_DIR/package_app/launch.sh" ;;
        "Git")
            run_setup "GIT" "$SCRIPT_DIR/git/launch.sh" ;;
        "Grub & Plymouth")
            run_setup "GRUB-PLYMOUTH" "$SCRIPT_DIR/grub_plymouth/launch.sh" ;;
        *)
            echo "👋 Exiting..."
            break
            ;;
    esac
done
