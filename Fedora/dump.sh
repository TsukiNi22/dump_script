#!/bin/bash
# Usage: sudo bash dump.sh
# Interactive menu running the setups of this folder (each one in <setup>/launch.sh)
#
# The menu (fzf) stays open: a setup runs from it and the menu comes back with the result.
# Internal modes called by the menu (state shared in $DUMP_STATE_DIR):
#   --entries          print the menu entries
#   --preview <n>      details of the entry n + its last run
#   --action <n>       fzf action of the entry n (run it, or quit)
#   --run <n>          run the entry n (output logged)
#   --log <n>          open the full log of the last run of the entry n
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

# Xartania banner (same as the file headers)
banner() {
    echo "${MAGENTA}${BOLD}"
    echo "    ██╗  ██╗ █████╗ ██████╗ ████████╗ █████╗ ███╗   ██╗██╗ █████╗"
    echo "    ╚██╗██╔╝██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║██║██╔══██╗"
    echo "     ╚███╔╝ ███████║██████╔╝   ██║   ███████║██╔██╗ ██║██║███████║"
    echo "     ██╔██╗ ██╔══██║██╔══██╗   ██║   ██╔══██║██║╚██╗██║██║██╔══██║"
    echo "    ██╔╝ ██╗██║  ██║██║  ██║   ██║   ██║  ██║██║ ╚████║██║██║  ██║"
    echo "    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝${RESET}"
    center " " "$DISPLAY_WIDTH" 32 "${GREY}Fedora dump script - by Tsukini${RESET}"
}

# =========================
# State
# =========================
SELF="$SCRIPT_DIR/dump.sh"
DUMP_STATE_DIR="${DUMP_STATE_DIR:-}"
USB_STATE_FILE="$DUMP_STATE_DIR/usb"

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

# Ask the main & cancel usb (again from the menu to edit them), saved in the state
select_usbs() {
    section "USB-SETUP"
    read -r vendor_id device_id <<< "$(select_usb "Choose the main usb (optional but recommended):")" || true
    vendor_id="${vendor_id:-}"
    device_id="${device_id:-}"
    check_usb "main" "$vendor_id" "$device_id"
    read -r cancel_vendor_id cancel_device_id <<< "$(select_usb "Choose the cancel usb (optional):")" || true
    cancel_vendor_id="${cancel_vendor_id:-}"
    cancel_device_id="${cancel_device_id:-}"
    check_usb "cancel" "$cancel_vendor_id" "$cancel_device_id"
    # One value per line: an empty id must not shift the next ones
    printf '%s\n' "$vendor_id" "$device_id" "$cancel_vendor_id" "$cancel_device_id" > "$USB_STATE_FILE"
}

load_usbs() {
    vendor_id=""
    device_id=""
    cancel_vendor_id=""
    cancel_device_id=""
    if [[ -f "$USB_STATE_FILE" ]]; then
        { read -r vendor_id; read -r device_id; read -r cancel_vendor_id; read -r cancel_device_id; } \
            < "$USB_STATE_FILE" || true
    fi
}

# =========================
# Menu
# =========================
# Print the menu entries (one per line), they depend on the selected usb
menu_entries() {
    local usb_state=""

    load_usbs
    if ! usb_is_plugged "$vendor_id" "$device_id"; then
        usb_state=" (Deactivation)"
    fi
    printf '%s\n' \
        "Pam Usb$usb_state" \
        "Usb Lock & Power Shutdown$usb_state" \
        "Screen Of Intruder$usb_state" \
        "Usb Keys (main: ${vendor_id:-none}:${device_id:-none}, cancel: ${cancel_vendor_id:-none}:${cancel_device_id:-none})" \
        "Dotfile" \
        "Package & App" \
        "Custom Package & Binary" \
        "AI" \
        "Git" \
        "Grub & Plymouth" \
        "Quit"
}

# Entry of index <n> (0 = first, index given by fzf)
entry_at() {
    menu_entries | sed -n "$(($1 + 1))p"
}

# Name of the log / status files of an entry ("Pam Usb (Deactivation)" -> Pam_Usb)
entry_key() {
    local name="${1%% (*}"

    echo "${name//[^A-Za-z0-9]/_}"
}

# Run an entry, its output (stdout + errors of failed) is kept in <key>.log and the result in <key>.status
run_entry() {
    local entry="$1"
    local key
    local name
    local status=0
    local -a cmd=()

    key=$(entry_key "$entry")
    load_usbs
    case "$entry" in
        "Pam Usb"*) name="PAM-USB"; cmd=("$SCRIPT_DIR/pam_usb/launch.sh" "$vendor_id" "$device_id") ;;
        "Usb Lock & Power Shutdown"*) name="USB_LOCK-POWER_SHUTDOWN"
            cmd=("$SCRIPT_DIR/usb_lock_and_power_shutdown/launch.sh" "$vendor_id" "$device_id" \
                "$cancel_vendor_id" "$cancel_device_id") ;;
        "Screen Of Intruder"*) name="TAKE-SCREEN-OF-INTRUDER"
            cmd=("$SCRIPT_DIR/take_screen_of_intruder/launch.sh" "$vendor_id" "$device_id") ;;
        "Usb Keys"*) name="USB-KEYS" ;;
        "Dotfile") name="DOTFILE"; cmd=("$SCRIPT_DIR/dotfile/launch.sh") ;;
        "Package & App") name="PACKAGE-APP"; cmd=("$SCRIPT_DIR/package_app/launch.sh") ;;
        "Custom Package & Binary") name="CUSTOM-PACKAGE"; cmd=("$SCRIPT_DIR/custom_package/launch.sh") ;;
        "AI") name="AI"; cmd=("$SCRIPT_DIR/ai/launch.sh") ;;
        "Git") name="GIT"; cmd=("$SCRIPT_DIR/git/launch.sh") ;;
        "Grub & Plymouth") name="GRUB-PLYMOUTH"; cmd=("$SCRIPT_DIR/grub_plymouth/launch.sh") ;;
        *) return 0 ;;
    esac

    export DUMP_LOG="$DUMP_STATE_DIR/$key.log"
    : > "$DUMP_LOG"
    clear
    banner
    section "$name"
    # Only stdout goes through tee: gum draws its prompts on stderr (needs the terminal)
    if [[ "$name" == "USB-KEYS" ]]; then
        select_usbs > >(tee -a "$DUMP_LOG") || status=1
    else
        bash "${cmd[@]}" > >(tee -a "$DUMP_LOG") || status=1
    fi
    sleep 0.1 # Let tee flush the end of the output
    echo
    if [[ "$status" -eq 0 ]]; then
        ok "${BOLD}$name${RESET} done"
        echo "OK $(date +%H:%M:%S)" > "$DUMP_STATE_DIR/$key.status"
    else
        failed "$name (see the errors above)"
        echo "FAILED $(date +%H:%M:%S)" > "$DUMP_STATE_DIR/$key.status"
    fi
    pause
}

# Details of an entry + the status and the end of the log of its last run
preview_entry() {
    local entry="$1"
    local key
    local result

    key=$(entry_key "$entry")
    bash "$SCRIPT_DIR/describe.sh" "$entry"
    if [[ ! -f "$DUMP_STATE_DIR/$key.status" ]]; then
        return 0
    fi
    read -r result _ < "$DUMP_STATE_DIR/$key.status"
    echo
    if [[ "$result" == "OK" ]]; then
        echo "${GREY}──────── Last run: ${GREEN}${BOLD}$(cat "$DUMP_STATE_DIR/$key.status")${RESET}${GREY} ────────${RESET}"
    else
        echo "${GREY}──────── Last run: ${RED}${BOLD}$(cat "$DUMP_STATE_DIR/$key.status")${RESET}${GREY} ────────${RESET}"
    fi
    tail -n 15 "$DUMP_STATE_DIR/$key.log" 2> /dev/null || true
    echo "${GREY}(ctrl-l: full log)${RESET}"
}

# =========================
# Internal modes (called by fzf)
# =========================
case "${1:-}" in
    --entries)
        menu_entries
        exit 0
        ;;
    --preview)
        preview_entry "$(entry_at "$2")"
        exit 0
        ;;
    --action)
        if [[ "$(entry_at "$2")" == "Quit" ]]; then
            echo "abort"
        else
            echo "execute(bash $(printf '%q' "$SELF") --run $2)+reload(bash $(printf '%q' "$SELF") --entries)"
        fi
        exit 0
        ;;
    --run)
        run_entry "$(entry_at "$2")"
        exit 0
        ;;
    --log)
        log="$DUMP_STATE_DIR/$(entry_key "$(entry_at "$2")").log"
        if [[ -f "$log" ]]; then
            less -R +G "$log"
        fi
        exit 0
        ;;
esac

# =========================
# Verification
# =========================
banner
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
install_packages gum fzf usbutils less || exit 1
DUMP_STATE_DIR=$(mktemp -d)
export DUMP_STATE_DIR
USB_STATE_FILE="$DUMP_STATE_DIR/usb"
trap 'rm -rf "$DUMP_STATE_DIR"' EXIT

select_usbs
pause

# =========================
# Program
# =========================
SELF_Q=$(printf '%q' "$SELF")
bash "$SELF" --entries | fzf --no-sort --layout=reverse --height=100% --cycle --no-info \
    --with-shell "bash -c" \
    --border rounded --border-label " 🔻 FEDORA-DUMP 🔻 " --border-label-pos 0:bottom \
    --header "enter: run  •  ctrl-l: last log  •  esc: quit  •  type: filter" --header-first \
    --prompt "Setup ❯ " --pointer "👉" \
    --preview "bash $SELF_Q --preview {n}" \
    --preview-window "right,60%,wrap,border-rounded" --preview-label " Details " \
    --bind "enter:transform(bash $SELF_Q --action {n})" \
    --bind "ctrl-l:execute(bash $SELF_Q --log {n})" \
    --color "border:6,label:5:bold,preview-border:6,preview-label:6:bold,header:8,prompt:6,pointer:5" \
    --color "hl:5,hl+:5,fg+:15:bold,bg+:236" \
    > /dev/null || true
clear
echo "👋 Exiting..."
