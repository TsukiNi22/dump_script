#!/bin/bash
# Usage: sudo bash grub_plymouth/launch.sh
# Install a grub theme from a repository (optional) and the plymouth theme of plymouth_theme/
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

THEME_DIR="$SCRIPT_DIR/plymouth_theme"
PLYMOUTH_THEMES="/usr/share/plymouth/themes"

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

# Boot config left to the user (a wrong edit can break the boot)
if [[ "$OS_FAMILY" == "arch" ]] && ! grep -q "^HOOKS=.*plymouth" /etc/mkinitcpio.conf; then
    warning "Add 'plymouth' to HOOKS in /etc/mkinitcpio.conf, then run: mkinitcpio -P"
fi
if [[ "$OS_FAMILY" != "rpm" ]] && ! grep -q "splash" /proc/cmdline; then
    warning "Add 'quiet splash' to the kernel parameters (GRUB_CMDLINE_LINUX_DEFAULT in /etc/default/grub)"
fi
