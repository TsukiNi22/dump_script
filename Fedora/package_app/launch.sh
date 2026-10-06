#!/bin/bash
# Usage: sudo bash package_app/launch.sh
# Install the packages & apps (a failed step is reported and the next ones still run)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

FEDORA_VERSION=$(rpm -E %fedora)
RPM_FUSION_URL="https://download1.rpmfusion.org"
FLATHUB_URL="https://dl.flathub.org/repo/flathub.flatpakrepo"
VSCODE_KEY="https://packages.microsoft.com/keys/microsoft.asc"
FAILED_STEPS=()

# Run a step inside a box, record it when it fails
step() {
    local name="$1"
    local label="$2"
    local status=0
    shift 2

    box_open "$name"
    "$@" || status=1
    box_close "$name"
    if [[ "$status" -ne 0 ]]; then
        failed "$label"
        FAILED_STEPS+=("$label")
    else
        ok "$label"
    fi
}

# =========================
# Steps
# =========================
# Commands chained with && -> set -e is ignored inside a function called by step
setup_vscode_repo() {
    rpm --import "$VSCODE_KEY" && cat > /etc/yum.repos.d/vscode.repo <<VSCODE
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
autorefresh=1
type=rpm-md
gpgcheck=1
gpgkey=$VSCODE_KEY
VSCODE
}

setup_wireshark() {
    dnf install -y wireshark && usermod -aG wireshark "$SUDO_USER"
}

setup_docker() {
    dnf install -y moby-engine docker-compose \
        && systemctl enable --now docker \
        && usermod -aG docker "$SUDO_USER"
}

# =========================
# Program
# =========================
step "BASE-PACKAGE" "Download base package" \
    dnf install -y dnf-plugins-core flatpak git curl wget tree ripgrep gh asciiquarium
step "SETUP-RPM-FUSION" "Setup RPM Fusion" \
    dnf install -y \
        "$RPM_FUSION_URL/free/fedora/rpmfusion-free-release-$FEDORA_VERSION.noarch.rpm" \
        "$RPM_FUSION_URL/nonfree/fedora/rpmfusion-nonfree-release-$FEDORA_VERSION.noarch.rpm"
step "SETUP-FLATHUB" "Setup Flathub" \
    flatpak remote-add --if-not-exists flathub "$FLATHUB_URL"

# Used by the zshrc aliases (cmake/make/docker/valgrind/tmux/zenity/play/xeyes/upower)
step "DEV-TOOLS" "Download development tools" \
    dnf install -y gcc gcc-c++ clang make cmake ccache gtest-devel valgrind python3 python3-pip \
        tmux zenity sox xeyes upower
step "SETUP-DOCKER" "Setup of docker" setup_docker
step "DOWNLOAD-CSFML" "Download of the csfml" dnf install -y CSFML CSFML-devel
step "CYBER-SECURITY" "Download cyber security package" dnf install -y binwalk gobuster hydra john
step "SETUP-WIRESHARK" "Setup of wireshark" setup_wireshark
step "VSCODE-REPO" "Setup of the vscode repository" setup_vscode_repo
step "VSCODE-SETUP" "Setup of vscode" dnf install -y code

# telegram-desktop comes from RPM Fusion
step "DESKTOP-APP" "Download of the desktop app" dnf install -y telegram-desktop qbittorrent
step "FLATPAK-APP" "Download of the flatpak app" \
    flatpak install -y --noninteractive flathub dev.vencord.Vesktop org.vinegarhq.Sober

if [[ ${#FAILED_STEPS[@]} -ne 0 ]]; then
    warning "Failed steps: ${FAILED_STEPS[*]}"
fi
info "Log out and in again to use the docker & wireshark groups"
