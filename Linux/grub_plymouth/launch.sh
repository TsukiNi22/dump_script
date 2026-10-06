#!/bin/bash
# Usage: sudo bash grub_plymouth/launch.sh
# Install a grub theme from a repository (optional) and the plymouth theme of plymouth_theme/
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

THEME_DIR="$SCRIPT_DIR/plymouth_theme"
PLYMOUTH_THEMES="/usr/share/plymouth/themes"
GRUB_DEFAULT="/etc/default/grub"
MKINITCPIO_CONF="/etc/mkinitcpio.conf"

install_packages git gum dracut grub2-tools grub2-common plymouth plymouth-scripts \
    plymouth-plugin-script plymouth-system-theme || exit 1

# =========================
# Grub
# =========================
repo_url=$(ask_input "Link of a grub theme repository (empty to skip):") || repo_url=""
if [[ -z "$repo_url" ]]; then
    skipped "Grub theme"
else
    clone_dir=$(mktemp -d)
    box_open "DOWNLOAD-GRUB-THEME"
    clone_status=0
    git clone --depth 1 "$repo_url" "$clone_dir" || clone_status=1
    box_close "DOWNLOAD-GRUB-THEME"
    if [[ "$clone_status" -ne 0 ]]; then
        failed "Download grub theme"
    elif [[ ! -f "$clone_dir/install.sh" ]]; then
        info "install.sh not found in the given repository"
        skipped "Installation grub theme"
    else
        ok "Download grub theme"
        box_open "INSTALLATION-GRUB-THEME"
        install_status=0
        (cd "$clone_dir" && bash install.sh < /dev/null) || install_status=1
        box_close "INSTALLATION-GRUB-THEME"
        if [[ "$install_status" -ne 0 ]]; then
            failed "Installation grub theme"
        else
            ok "Installation grub theme"
        fi
    fi
    rm -rf "$clone_dir"
fi

# =========================
# Plymouth
# =========================
theme_path=$(find "$THEME_DIR" -mindepth 1 -maxdepth 1 -type d | head -n 1)
if [[ -z "$theme_path" ]]; then
    failed "No plymouth theme found in $THEME_DIR"
    exit 1
fi
theme_name=$(basename "$theme_path")
info "Plymouth theme used: $theme_path"

rm -rf "${PLYMOUTH_THEMES:?}/$theme_name"
cp -r "$theme_path" "$PLYMOUTH_THEMES/"
restorecon -R "$PLYMOUTH_THEMES/$theme_name" 2> /dev/null || true
ok "Plymouth theme copied"

# =========================
# Boot config
# =========================
# Every edited file is saved first in <file>.dump_script.bak
backup() {
    cp -f "$1" "$1.dump_script.bak"
}

# Arch: the plymouth hook in the initramfs, after udev / systemd (arch wiki)
setup_mkinitcpio_hook() {
    if grep -qE '^HOOKS=.*\bplymouth\b' "$MKINITCPIO_CONF"; then
        ok "Plymouth hook already in $MKINITCPIO_CONF"
        return 0
    fi
    backup "$MKINITCPIO_CONF"
    sed -i -E '/^HOOKS=/ s/\b(systemd|udev)\b/\1 plymouth/' "$MKINITCPIO_CONF"
    if ! grep -qE '^HOOKS=.*\bplymouth\b' "$MKINITCPIO_CONF"; then
        warning "No udev / systemd hook in $MKINITCPIO_CONF: add 'plymouth' to HOOKS yourself"
        return 0
    fi
    ok "Plymouth hook added in $MKINITCPIO_CONF"
}

# Kernel parameters showing the splash (fedora: rhgb), then grub.cfg regenerated
setup_grub_splash() {
    if [[ ! -f "$GRUB_DEFAULT" ]]; then
        warning "No $GRUB_DEFAULT (not grub): add 'quiet splash' to the kernel parameters of your boot loader"
        return 0
    fi
    if grep -qE '^GRUB_CMDLINE_LINUX_DEFAULT=.*\b(splash|rhgb)\b' "$GRUB_DEFAULT"; then
        ok "Splash already in the kernel parameters"
        return 0
    fi
    backup "$GRUB_DEFAULT"
    if grep -q '^GRUB_CMDLINE_LINUX_DEFAULT=' "$GRUB_DEFAULT"; then
        sed -i -E '/^GRUB_CMDLINE_LINUX_DEFAULT=/ { s/\bquiet\b ?//; s/="/="quiet splash /; s/ "$/"/ }' "$GRUB_DEFAULT"
    else
        echo 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"' >> "$GRUB_DEFAULT"
    fi
    ok "Kernel parameters: $(grep '^GRUB_CMDLINE_LINUX_DEFAULT=' "$GRUB_DEFAULT")"
    case "$OS_FAMILY" in
        deb) update-grub ;;
        arch) grub-mkconfig -o /boot/grub/grub.cfg ;;
        rpm) grub2-mkconfig -o /boot/grub2/grub.cfg ;;
    esac
}

if [[ "$OS_FAMILY" == "arch" ]]; then
    setup_mkinitcpio_hook
fi
setup_grub_splash || warning "grub.cfg not regenerated: run the grub mkconfig of your system"

# =========================
# Initramfs
# =========================
# The initramfs embeds the theme: regenerated (can take a while)
# fedora: dracut / debian: update-initramfs (both through -R), arch: mkinitcpio
info "Start regeneration of the initramfs"
case "$OS_FAMILY" in
    arch) plymouth-set-default-theme "$theme_name" && mkinitcpio -P ;;
    *) plymouth-set-default-theme -R "$theme_name" ;;
esac || {
    failed "Plymouth theme selection ($theme_name)"
    exit 1
}
ok "Plymouth setup ($theme_name)"
