#!/bin/bash
# Shared helpers of the Fedora setup scripts (sourced only, never executed)
set -euo pipefail

# =========================
# Colors
# =========================
RED=$'\033[31m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
BLUE=$'\033[34m'
MAGENTA=$'\033[35m'
CYAN=$'\033[36m'
RESET=$'\033[0m'

# =========================
# Logs
# =========================
ok() {
    echo "[${GREEN}OK${RESET}] $*"
}

failed() {
    echo "[${RED}FAILED${RESET}] $*" >&2
}

skipped() {
    echo "[${YELLOW}SKIPPED${RESET}] $*"
}

warning() {
    echo "[${YELLOW}WARNING${RESET}] $*"
}

info() {
    echo "[${BLUE}INFO${RESET}] $*"
}

# Section title of a setup: ═══ [NAME] ═══
section() {
    echo "═══════════════ [${CYAN}$1${RESET}] ═══════════════"
}

# Box around the output of a command: ╔═ 🔻 [NAME] 🔻 ═╗ ... ╚═ 🔺 [NAME] 🔺 ═╝
box_open() {
    echo "╔════ 🔻 [${CYAN}$1${RESET}] 🔻 ════╗"
}

box_close() {
    echo "╚════ 🔺 [${CYAN}$1${RESET}] 🔺 ════╝"
}

# =========================
# Tools
# =========================
# Install packages inside a box, return 1 on failure
install_packages() {
    local status=0

    box_open "DOWNLOAD-PACKAGE"
    dnf install -y "$@" || status=1
    box_close "DOWNLOAD-PACKAGE"
    if [[ "$status" -ne 0 ]]; then
        failed "Download package ($*)"
        return 1
    fi
    ok "Download package"
}

# Run a command as the user who launched the setup through sudo
run_as_user() {
    sudo -u "$SUDO_USER" -H "$@"
}

# Install a file owned by root with a clean SELinux context (mv would keep the home context)
install_root_file() {
    local mode="$1"
    local src="$2"
    local dest="$3"

    install -D -o root -g root -m "$mode" "$src" "$dest"
    restorecon "$dest" 2> /dev/null || true
}

# Escape a value used as the replacement part of a sed substitution with '|' as separator
escape_sed() {
    printf '%s' "$1" | sed 's/[&|\\]/\\&/g'
}

# Check that a usb with the given vendor-id and device-id is plugged
usb_is_plugged() {
    [[ -n "$1" && -n "$2" ]] && lsusb -d "$1:$2" > /dev/null 2>&1
}

# =========================
# Checks
# =========================
if [[ $EUID -ne 0 || -z "${SUDO_USER:-}" || "${SUDO_USER:-}" == "root" ]]; then
    failed "The setup must be run with sudo from the user account (sudo make)"
    exit 1
fi
USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
