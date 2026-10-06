#!/bin/bash
# Usage: sudo bash custom_package/launch.sh
# Install the custom packages & binaries: libutils (rpm mirror) and xstyle (built from the skills repository)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

LIBUTILS_SETUP_URL="https://raw.githubusercontent.com/$GITHUB_USER/libutils/main/setup.sh"
LIBUTILS_REPO_FILE="/etc/yum.repos.d/libutils.repo"
# Stable channel: optimized (op), debug (db) and asan (as) builds with their headers (dev)
LIBUTILS_PACKAGES=(libutils libutils-dev libutils-op libutils-dev-op libutils-db libutils-dev-db
    libutils-as libutils-dev-as)

# xstyle is built with clang++ and libutils
install_packages gum git curl cmake make clang gcc-c++ python3 openssl-devel || exit 1

# =========================
# Setups
# =========================
setup_libutils() {
    if [[ ! -f "$LIBUTILS_REPO_FILE" ]]; then
        curl -fsSL "$LIBUTILS_SETUP_URL" | bash -s -- --no-sudo || return 1
    fi
    dnf install -y --refresh "${LIBUTILS_PACKAGES[@]}"
}

setup_xstyle() {
    skills_setup install xstyle
}

# =========================
# Program
# =========================
CHOICES=$(ask_choose --multi --selected "libutils,xstyle" "Custom package & binary to install:" \
    "libutils" "xstyle") || CHOICES=""
if [[ -z "$CHOICES" ]]; then
    skipped "Custom package & binary"
    exit 0
fi

# mapfile: a setup reading stdin would eat the next choices of a while read loop
mapfile -t SELECTED <<< "$CHOICES"
status=0
for choice in "${SELECTED[@]}"; do
    run_step "SETUP-${choice^^}" "Setup of $choice" "setup_$choice" || status=1
done
exit "$status"
