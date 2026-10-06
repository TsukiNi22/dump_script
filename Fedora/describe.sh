#!/bin/bash
# Usage: bash describe.sh <menu entry>
# Details of a menu entry, shown in the preview of the menu (fzf)
set -euo pipefail

BOLD=$'\033[1m'
MAGENTA=$'\033[35m'
CYAN=$'\033[36m'
YELLOW=$'\033[33m'
GREY=$'\033[90m'
RESET=$'\033[0m'

title() {
    echo "${BOLD}${MAGENTA}$1${RESET}"
    echo "${GREY}$(printf '─%.0s' $(seq 1 ${#1}))${RESET}"
    echo
}

note() {
    echo
    echo "${YELLOW}⚠ $1${RESET}"
}

# Bullets "- " -> "•", lines ending with ':' -> cyan sub-titles
format() {
    sed -e "s/^\( *\)- /\1${CYAN}•${RESET} /" -e "s/^\([A-Z][^•]*:\)$/${CYAN}${BOLD}\1${RESET}/"
}

{
    case "${1:-}" in
        "System Update")
            title "System Update"
            echo "Runs on the loading screen at launch, run it again from here:"
            echo "  - dnf update"
            echo "  - packages of the menu: gum, fzf, usbutils, less, curl"
            ;;
        "Pam Usb"*)
            title "Pam Usb"
            echo "${YELLOW}Needs the main usb key${RESET} (not set: chosen when the setup starts, or deactivation only)"
            echo
            echo "Activate (main usb plugged):"
            echo "  - build pam_usb from github.com/mcdope/pam_usb"
            echo "  - write /etc/security/pam_usb.conf (vendor, model, serial, volume uuid of the main usb)"
            echo "  - replace /etc/pam.d/system-auth & password-auth:"
            echo "    password AND main usb required to log in / unlock / sudo"
            echo
            echo "Deactivate:"
            echo "  - put back the auth files without pam_usb (password only)"
            note "The auth files are only replaced when pam_usb.so is installed (no login lock-out)"
            ;;
        "Usb Lock & Power Shutdown"*)
            title "Usb Lock & Power Shutdown"
            echo "${YELLOW}Needs the main usb key${RESET} (not set: chosen when the setup starts, or deactivation only)"
            echo
            echo "Activation (main usb plugged), choose USB Lock, Power Shutdown or both:"
            echo "  - USB Lock: udev rule, main usb removed -> lock the session + suspend"
            echo "  - Power Shutdown: udev rule, charger unplugged -> power off"
            echo "  - /usr/local/bin/usb-lock_power-shutdown.sh run by the rules"
            echo "  - cancel usb (optional): plugged -> the lock / shutdown don't happen"
            echo
            echo "Deactivation (always possible, one of them or both):"
            echo "  - remove the rule(s), the script when no rule is left, reload udev"
            ;;
        "Screen Of Intruder"*)
            title "Screen Of Intruder"
            echo "${YELLOW}Needs the main usb key${RESET} (not set: chosen when the setup starts, or deactivation only)"
            echo
            echo "Activate (main usb plugged):"
            echo "  - install fswebcam"
            echo "  - usb-capture.service (runs as the user) checks every second"
            echo "  - screen locked AND main usb unplugged -> webcam picture in"
            echo "    ~/Images/Intruder_Picture/intruder_<date>.jpg"
            echo
            echo "Deactivate:"
            echo "  - stop & remove the service and its scripts"
            ;;
        "Usb Keys"*)
            title "Usb Keys"
            echo "Optional: choose the usb used by the 3 usb setups (from lsusb or written by hand):"
            echo "  - main: Pam Usb, Usb Lock & Power Shutdown, Screen Of Intruder"
            echo "  - cancel (optional): cancels the Usb Lock & Power Shutdown"
            note "Not set: the usb setups propose to choose it when they start (or deactivation only)"
            ;;
        "Dotfile")
            title "Dotfile"
            echo "Packages: neovim, vim, zsh, zoxide, fastfetch, chafa, sl, tmux, gcc, tree-sitter-cli"
            echo
            echo "  - Oh-My-Zsh (unattended), zsh as default shell"
            echo "  - ~/.zshrc (old one saved in ~/.zshrc.bak), 'dump' alias -> this repository"
            echo "  - ~/.config/nvim: lazy.nvim, rose-pine, treesitter, nvim-cmp, headers & protos"
            echo "  - ~/.config/fastfetch: random picture at each launch (rdm_img.sh)"
            echo "  - ~/.tmux.conf, ~/.config/git/ignore"
            ;;
        "Package & App")
            title "Package & App"
            echo "Repositories: RPM Fusion (free & nonfree), Flathub, vscode"
            echo
            echo "  - base: git, curl, wget, tree, ripgrep, gh, asciiquarium"
            echo "  - dev: gcc, clang, cmake, ccache, gtest, valgrind, python3, tmux"
            echo "  - docker (moby-engine, docker-compose, docker group)"
            echo "  - CSFML, binwalk, gobuster, hydra, john, wireshark (wireshark group)"
            echo "  - apps: vscode, telegram, qbittorrent, vesktop & sober (flatpak)"
            note "A failed step is reported and the next ones still run"
            ;;
        "Custom Package & Binary")
            title "Custom Package & Binary"
            echo "Choose one or both:"
            echo "  - libutils: TsukiNi22 rpm mirror + every build (optimized, debug, asan + headers)"
            echo "  - xstyle: coding style checker, built from the skills repository into ~/.local/bin"
            note "xstyle needs libutils: select both on a fresh machine"
            ;;
        "AI")
            title "AI"
            echo "Choose any of:"
            echo "  - Claude Code: native installer (~/.local/bin/claude)"
            echo "  - Ollama: official installer (/usr/local/bin/ollama + ollama.service)"
            echo "  - Skills: every skill in ~/.claude/skills + their tools (xstyle)"
            echo "  - Skills context: CLAUDE.md, RTK.md, hooks and rtk in ~/.claude"
            note "The skills come from the local clone of the Git setup, or a managed clone otherwise"
            ;;
        "Git")
            title "Git"
            echo "  - git user (name, email), core.editor nvim, init.defaultBranch main"
            echo "  - ~/delivery & ~/personal_delivery repositories"
            echo "  - ~/.ssh/git key: ed25519 (or ed25519-sk on a FIDO2 key), passphrase typed hidden"
            echo "    on the terminal, 256 KDF rounds (slow brute force of a stolen key)"
            echo "  - github host in ~/.ssh/config: post-quantum key exchange only"
            echo "    (mlkem768x25519 / sntrup761x25519), key kept in the agent after the first unlock"
            echo "  - clone (https, push with ssh) any of:"
            echo "      libutils, cpp_project_template -> ~/personal_delivery/cpp/"
            echo "      skills, docker-image -> ~/personal_delivery/other/"
            echo "      other links (one per line) -> chosen folder"
            ;;
        "Grub & Plymouth")
            title "Grub & Plymouth"
            echo "  - grub theme from a repository with an install.sh (optional, empty link to skip)"
            echo "  - plymouth theme of grub_plymouth/plymouth_theme (loader_2)"
            echo "  - regenerate the initramfs (can take a while)"
            ;;
        "Quit")
            title "Quit"
            echo "Leave the menu"
            ;;
        *)
            echo "No description for '${1:-}'"
            ;;
    esac
} | format
