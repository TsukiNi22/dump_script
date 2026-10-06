#!/bin/bash
# Usage: sudo bash custom_package/launch.sh
# Install the custom packages & binaries: libutils (rpm / deb mirror, built from the sources on arch)
# and xstyle (built from the skills repository)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

LIBUTILS_SETUP_URL="https://raw.githubusercontent.com/$GITHUB_USER/libutils/main/setup.sh"
LIBUTILS_REPO="https://github.com/$GITHUB_USER/libutils.git"
# Stable channel: optimized (op), debug (db) and asan (as) builds with their headers (dev)
LIBUTILS_PACKAGES=(libutils libutils-dev libutils-op libutils-dev-op libutils-db libutils-dev-db
    libutils-as libutils-dev-as)

# xstyle is built with clang++ and libutils
install_packages gum git curl gpg cmake make clang gcc-c++ python3 openssl-devel || exit 1

# =========================
# Setups
# =========================
# Mirror of libutils already set up for this family
libutils_repo_ready() {
    case "$OS_FAMILY" in
        rpm) [[ -f /etc/yum.repos.d/libutils.repo ]] ;;
        deb) [[ -f /etc/apt/sources.list.d/libutils.list ]] ;;
    esac
}

# No arch mirror: Debug + Asan + Optimized builds from the sources into /usr/local
setup_libutils_sources() {
    local build_dir

    build_dir=$(mktemp -d)
    git clone -q --depth 1 "$LIBUTILS_REPO" "$build_dir/libutils" \
        && cmake -S "$build_dir/libutils" -B "$build_dir/libutils/build" \
        && cmake --build "$build_dir/libutils/build" --target install_release --parallel "$(nproc)"
    local status=$?
    rm -rf "$build_dir"
    return "$status"
}

setup_libutils() {
    if [[ "$OS_FAMILY" == "arch" ]]; then
        setup_libutils_sources
        return
    fi
    if ! libutils_repo_ready; then
        curl -fsSL "$LIBUTILS_SETUP_URL" | bash -s -- --no-sudo || return 1
    fi
    if [[ "$OS_FAMILY" == "deb" ]]; then
        apt-get update || return 1
    fi
    pkg_install "${LIBUTILS_PACKAGES[@]}"
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
