#!/bin/bash
# Usage: sudo bash pam_usb/launch.sh [<vendor-id> <device-id>]
# Build pam_usb and require the usb in the system-auth / password-auth stacks (deactivate it without usb)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

VENDOR_ID="${1:-}"
DEVICE_ID="${2:-}"
PAM_USB_REPO="https://github.com/mcdope/pam_usb.git"
PAM_USB_MODULE="/usr/lib64/security/pam_usb.so"

install_packages gum gcc make git python3 pkgconf-pkg-config pam-devel libxml2-devel glib2-devel \
    udisks-devel libudisks2-devel libevdev-devel || exit 1

# Put back the auth stacks without pam_usb
deactivate() {
    install_root_file 644 "$SCRIPT_DIR/disabled_system-auth" /etc/pam.d/system-auth
    ok "Deactivation of system-auth"
    install_root_file 644 "$SCRIPT_DIR/disabled_password-auth" /etc/pam.d/password-auth
    ok "Deactivation of password-auth"
}

CHOICE="Deactivate"
if usb_is_plugged "$VENDOR_ID" "$DEVICE_ID"; then
    CHOICE=$(gum choose "Activate" "Deactivate") || CHOICE="Cancel"
fi
case "$CHOICE" in
    "Activate") ;;
    "Deactivate") deactivate; exit 0 ;;
    *) skipped "Pam usb"; exit 0 ;;
esac

# =========================
# Build
# =========================
build_dir=$(mktemp -d)
trap 'rm -rf "$build_dir"' EXIT
box_open "DOWNLOAD-PAM-USB"
build_status=0
git clone --depth 1 "$PAM_USB_REPO" "$build_dir" \
    && make -C "$build_dir" > /dev/null \
    && make -C "$build_dir" install > /dev/null \
    || build_status=1
box_close "DOWNLOAD-PAM-USB"

# A missing module in the auth stack would block every login !!!
if [[ "$build_status" -ne 0 || ! -f "$PAM_USB_MODULE" ]]; then
    failed "Build of pam usb ($PAM_USB_MODULE not installed)"
    exit 1
fi
ok "Download pam usb"

# =========================
# Config
# =========================
if ! bash "$SCRIPT_DIR/set-file.sh" "$VENDOR_ID" "$DEVICE_ID"; then
    failed "Setup of pam usb system file"
    exit 1
fi
ok "Setup of pam usb system file"
