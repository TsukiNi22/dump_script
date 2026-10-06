#!/bin/bash
# Usage: sudo bash dump.sh
# Interactive menu running the setups of this folder (each one in <setup>/launch.sh)
#
# Everything happens in one fzf window: a setup runs in the background, its output is shown live on the right
# and its questions are asked in the list of the window (utils.sh ask_* -> fzf --listen API).
# Internal modes called by fzf (state shared in $DUMP_STATE_DIR):
#   --entries               print the menu entries
#   --header                print the header (keys + running / last setup)
#   --prompt                print the prompt (menu or running)
#   --preview <n>           details of the entry n + its last / running output
#   --action <n> <f> <q>    enter: run the entry n, or validate a question (<f> = selected items, <q> = query)
#   --escape                esc: cancel a question, or quit
#   --toggle-log            ctrl-l: switch the preview between the end and the whole output
#   --task <n|startup>      run a task (background)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

SELF="$SCRIPT_DIR/dump.sh"
SELF_Q=$(printf '%q' "$SELF")
LOG_TAIL=20 # Lines of output shown under the details (ctrl-l: everything)

# =========================
# State
# =========================
DUMP_STATE_DIR="${DUMP_STATE_DIR:-}"
USB_STATE_FILE="$DUMP_STATE_DIR/usb"
RUNNING_FILE="$DUMP_STATE_DIR/running" # "<pid> <key> <name>" of the running task
MODE_FILE="$DUMP_STATE_DIR/mode"       # menu | answer (a task waits for an answer)

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

# Print "<pid> <key> <name>" of the running task (nothing when no task runs)
running_task() {
    local pid

    [[ -f "$RUNNING_FILE" ]] || return 0
    read -r pid _ < "$RUNNING_FILE"
    if kill -0 "$pid" 2> /dev/null; then
        cat "$RUNNING_FILE"
    fi
}

mode() {
    cat "$MODE_FILE" 2> /dev/null || echo "menu"
}

# =========================
# Usb selection
# =========================
# Ask a usb, print "<vendor-id>\n<device-id>" (empty when none)
select_usb() {
    local header="$1"
    local -a choices=()
    local selected=""
    local vendor_id=""
    local device_id=""

    mapfile -t choices < <(lsusb | awk '{print $6 " - " substr($0, index($0, $7))}')
    selected=$(ask_choose "$header" "${choices[@]}" "Manual" "None") || selected="None"
    case "$selected" in
        "Manual")
            vendor_id=$(ask_input "Usb vendor-id (ex: ffff):") || vendor_id=""
            device_id=$(ask_input "Usb device-id (ex: 5678):") || device_id=""
            ;;
        "None"|"")
            ;;
        *)
            vendor_id=$(echo "$selected" | cut -d' ' -f1 | cut -d: -f1)
            device_id=$(echo "$selected" | cut -d' ' -f1 | cut -d: -f2)
            ;;
    esac
    printf '%s\n%s\n' "$vendor_id" "$device_id"
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

# Ask the main & cancel usb, saved in the state (one value per line: an empty id must not shift the others)
select_usbs() {
    local -a main=()
    local -a cancel=()

    mapfile -t main < <(select_usb "Main usb (optional but recommended):")
    check_usb "main" "${main[0]:-}" "${main[1]:-}"
    mapfile -t cancel < <(select_usb "Cancel usb (optional):")
    check_usb "cancel" "${cancel[0]:-}" "${cancel[1]:-}"
    printf '%s\n' "${main[0]:-}" "${main[1]:-}" "${cancel[0]:-}" "${cancel[1]:-}" > "$USB_STATE_FILE"
}

# =========================
# Tasks
# =========================
task_update() {
    section "UPDATE"
    box_open "UPDATE-PACKAGE"
    if ! dnf update -y; then
        box_close "UPDATE-PACKAGE"
        failed "Update package"
        return 1
    fi
    box_close "UPDATE-PACKAGE"
    ok "Update package"
    install_packages gum fzf usbutils less curl
}

task_usb_keys() {
    section "USB-KEYS"
    select_usbs
}

task_startup() {
    task_update
    task_usb_keys
}

# Run a setup script: task_setup <script> [arg...]
task_setup() {
    bash "$@"
}

# =========================
# Menu
# =========================
# Print the menu entries (one per line), they depend on the selected usb
# While a task runs the list is locked: one line, the output is on the right (questions excepted)
menu_entries() {
    local usb_state=""
    local -a task=()

    read -r -a task <<< "$(running_task)" || true
    if [[ ${#task[@]} -gt 0 ]]; then
        echo "${YELLOW}${BOLD}Running: ${task[2]}${RESET} ${GREY}(output on the right)${RESET}"
        return 0
    fi
    load_usbs
    if ! usb_is_plugged "$vendor_id" "$device_id"; then
        usb_state=" (Deactivation)"
    fi
    printf '%s\n' \
        "System Update" \
        "Usb Keys (main: ${vendor_id:-none}:${device_id:-none}, cancel: ${cancel_vendor_id:-none}:${cancel_device_id:-none})" \
        "Pam Usb$usb_state" \
        "Usb Lock & Power Shutdown$usb_state" \
        "Screen Of Intruder$usb_state" \
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

# Set TASK_NAME and TASK_CMD (function + arguments) of an entry, return 1 for Quit
entry_task() {
    load_usbs
    case "$1" in
        "startup") TASK_NAME="STARTUP"; TASK_CMD=(task_startup) ;;
        "System Update") TASK_NAME="SYSTEM-UPDATE"; TASK_CMD=(task_update) ;;
        "Usb Keys"*) TASK_NAME="USB-KEYS"; TASK_CMD=(task_usb_keys) ;;
        "Pam Usb"*) TASK_NAME="PAM-USB"
            TASK_CMD=(task_setup "$SCRIPT_DIR/pam_usb/launch.sh" "$vendor_id" "$device_id") ;;
        "Usb Lock & Power Shutdown"*) TASK_NAME="USB_LOCK-POWER_SHUTDOWN"
            TASK_CMD=(task_setup "$SCRIPT_DIR/usb_lock_and_power_shutdown/launch.sh" "$vendor_id" "$device_id" \
                "$cancel_vendor_id" "$cancel_device_id") ;;
        "Screen Of Intruder"*) TASK_NAME="TAKE-SCREEN-OF-INTRUDER"
            TASK_CMD=(task_setup "$SCRIPT_DIR/take_screen_of_intruder/launch.sh" "$vendor_id" "$device_id") ;;
        "Dotfile") TASK_NAME="DOTFILE"; TASK_CMD=(task_setup "$SCRIPT_DIR/dotfile/launch.sh") ;;
        "Package & App") TASK_NAME="PACKAGE-APP"; TASK_CMD=(task_setup "$SCRIPT_DIR/package_app/launch.sh") ;;
        "Custom Package & Binary") TASK_NAME="CUSTOM-PACKAGE"; TASK_CMD=(task_setup "$SCRIPT_DIR/custom_package/launch.sh") ;;
        "AI") TASK_NAME="AI"; TASK_CMD=(task_setup "$SCRIPT_DIR/ai/launch.sh") ;;
        "Git") TASK_NAME="GIT"; TASK_CMD=(task_setup "$SCRIPT_DIR/git/launch.sh") ;;
        "Grub & Plymouth") TASK_NAME="GRUB-PLYMOUTH"; TASK_CMD=(task_setup "$SCRIPT_DIR/grub_plymouth/launch.sh") ;;
        *) return 1 ;;
    esac
}

# Run a task in the background: everything (questions excepted) goes to <key>.log, the result to <key>.status
run_task() {
    local entry="$1"
    local key
    local status=0

    entry_task "$entry" || return 0
    key=$(entry_key "$entry")
    if [[ "$entry" == "startup" ]]; then
        key="System_Update"
    fi
    export DUMP_LOG="$DUMP_STATE_DIR/$key.log"
    echo "$$ $key $TASK_NAME" > "$RUNNING_FILE"
    fzf_post "$MENU_ACTIONS"
    {
        section "$TASK_NAME"
        "${TASK_CMD[@]}" || status=1
        echo
        if [[ "$status" -eq 0 ]]; then
            ok "${BOLD}$TASK_NAME${RESET} done"
        else
            failed "$TASK_NAME (see the errors above)"
        fi
    } > "$DUMP_LOG" 2>&1 < /dev/null
    if [[ "$status" -eq 0 ]]; then
        echo "OK $TASK_NAME $(date +%H:%M:%S)" > "$DUMP_STATE_DIR/$key.status"
    else
        echo "FAILED $TASK_NAME $(date +%H:%M:%S)" > "$DUMP_STATE_DIR/$key.status"
    fi
    echo "$key" > "$DUMP_STATE_DIR/last"
    rm -f "$RUNNING_FILE"
    fzf_post "$MENU_ACTIONS+first"
}

# Colored result of a status file
status_line() {
    local result
    local rest

    read -r result rest < "$1"
    if [[ "$result" == "OK" ]]; then
        echo "${GREEN}${BOLD}✔ $rest${RESET}"
    else
        echo "${RED}${BOLD}✘ $rest${RESET}"
    fi
}

menu_header() {
    local -a task=()
    local last

    read -r -a task <<< "$(running_task)" || true
    echo "enter: run  •  ctrl-l: whole output  •  esc: quit  •  ctrl-c: force quit  •  type: filter"
    if [[ ${#task[@]} -gt 0 ]]; then
        echo "${YELLOW}${BOLD}⏳ Running: ${task[2]}${RESET}"
    elif [[ -f "$DUMP_STATE_DIR/last" ]]; then
        last=$(cat "$DUMP_STATE_DIR/last")
        echo "Last: $(status_line "$DUMP_STATE_DIR/$last.status")"
    else
        echo "${GREY}No setup run yet${RESET}"
    fi
}

# Output of a task: live while it runs (tail -f until the task ends), whole or end when finished
show_output() {
    local key="$1"
    local pid="$2"
    local log="$DUMP_STATE_DIR/$key.log"

    [[ -f "$log" ]] || return 0
    if [[ -n "$pid" ]]; then
        tail -n +1 -f --pid="$pid" "$log"
    elif [[ -f "$DUMP_STATE_DIR/full_log" ]]; then
        cat "$log"
    else
        tail -n "$LOG_TAIL" "$log"
        echo "${GREY}(ctrl-l: whole output)${RESET}"
    fi
}

preview_entry() {
    local entry="$1"
    local key
    local -a task=()

    read -r -a task <<< "$(running_task)" || true
    # A question is asked: output of the task asking it
    if [[ "$(mode)" == "answer" && ${#task[@]} -gt 0 ]]; then
        echo "${BOLD}${MAGENTA}${task[2]}${RESET} ${GREY}waits for an answer (list on the left)${RESET}"
        echo
        cat "$DUMP_STATE_DIR/${task[1]}.log"
        return 0
    fi
    # A task runs (list locked): its live output
    if [[ ${#task[@]} -gt 0 ]]; then
        echo "${BOLD}${MAGENTA}${task[2]}${RESET} ${GREY}is running${RESET}"
        echo
        show_output "${task[1]}" "${task[0]}"
        return 0
    fi
    key=$(entry_key "$entry")
    bash "$SCRIPT_DIR/describe.sh" "$entry"
    if [[ ${#task[@]} -gt 0 && "${task[1]}" == "$key" ]]; then
        echo
        echo "${GREY}──────── ${YELLOW}${BOLD}⏳ Running${RESET}${GREY} ────────${RESET}"
        show_output "$key" "${task[0]}"
    elif [[ -f "$DUMP_STATE_DIR/$key.status" ]]; then
        echo
        echo "${GREY}──────── Last run: ${RESET}$(status_line "$DUMP_STATE_DIR/$key.status")${GREY} ────────${RESET}"
        show_output "$key" ""
    fi
}

# Actions putting the list back (menu, or the locked running line) after a question / a task change
MENU_ACTIONS="reload-sync(bash $SELF_Q --entries)+transform-prompt(bash $SELF_Q --prompt)+transform-header(bash $SELF_Q --header)"
MENU_ACTIONS+="+clear-query+deselect-all+refresh-preview"

# Enter: validate the question, or run the entry
action_enter() {
    local index="$1"
    local selected_file="$2"
    local query="$3"
    local dir="$DUMP_STATE_DIR/ask"
    local entry

    if [[ "$(mode)" == "answer" ]]; then
        case "$(cat "$dir/kind")" in
            choose|multi)
                # Nothing under the cursor (filtered out): wait for a valid choice
                if [[ ! -s "$selected_file" ]]; then
                    echo "ignore"
                    return 0
                fi
                cp "$selected_file" "$dir/answer" ;;
            input) printf '%s\n' "$query" > "$dir/answer" ;;
            write) tr -s ' ' '\n' <<< "$query" > "$dir/answer" ;;
        esac
        echo "menu" > "$MODE_FILE"
        echo "ok" > "$dir/status"
        echo "$MENU_ACTIONS"
        return 0
    fi

    # List locked while a task runs
    if [[ -n "$(running_task)" ]]; then
        echo "ignore"
        return 0
    fi
    entry=$(entry_at "$index")
    if [[ "$entry" == "Quit" ]]; then
        action_escape
        return 0
    fi
    setsid bash "$SELF" --task "$index" > /dev/null 2>&1 < /dev/null &
    echo "refresh-preview"
}

# Esc: cancel the question, or quit (not while a setup runs)
action_escape() {
    if [[ "$(mode)" == "answer" ]]; then
        echo "menu" > "$MODE_FILE"
        echo "cancel" > "$DUMP_STATE_DIR/ask/status"
        echo "$MENU_ACTIONS"
    elif [[ -n "$(running_task)" ]]; then
        echo "transform-header(bash $SELF_Q --header; echo '${RED}A setup is running: quit after its end${RESET}')"
    else
        echo "abort"
    fi
}

# =========================
# Internal modes (called by fzf)
# =========================
case "${1:-}" in
    --entries) menu_entries; exit 0 ;;
    --header) menu_header; exit 0 ;;
    --prompt)
        if [[ -n "$(running_task)" ]]; then echo "Running ❯ "; else echo "Setup ❯ "; fi
        exit 0 ;;
    --preview) preview_entry "$(entry_at "$2")"; exit 0 ;;
    --action) action_enter "$2" "$3" "${4:-}"; exit 0 ;;
    --escape) action_escape; exit 0 ;;
    --toggle-log)
        if [[ -f "$DUMP_STATE_DIR/full_log" ]]; then
            rm -f "$DUMP_STATE_DIR/full_log"
        else
            touch "$DUMP_STATE_DIR/full_log"
        fi
        exit 0 ;;
    --task)
        if [[ "$2" == "startup" ]]; then
            run_task "startup"
        else
            run_task "$(entry_at "$2")"
        fi
        exit 0 ;;
esac

# =========================
# Program
# =========================
if ! grep -q "^ID=fedora" /etc/os-release; then
    failed "This script must be run on Fedora"
    exit 1
fi
# The window needs fzf (+ curl for its API) before anything else
if ! command -v fzf > /dev/null || ! command -v curl > /dev/null; then
    dnf install -y -q fzf curl
fi

DUMP_STATE_DIR=$(mktemp -d)
export DUMP_STATE_DIR
# ctrl-c (forced quit): stop the running task (own process group from setsid) before removing the state
cleanup() {
    local pid

    if [[ -f "$DUMP_STATE_DIR/running" ]]; then
        read -r pid _ < "$DUMP_STATE_DIR/running"
        kill -- "-$pid" 2> /dev/null || true
    fi
    rm -rf "$DUMP_STATE_DIR"
}
trap cleanup EXIT
echo "menu" > "$DUMP_STATE_DIR/mode"

# The startup (update + usb keys) runs as soon as the window is open
bash "$SELF" --entries | fzf --listen --no-sort --layout=reverse --height=100% --cycle --no-info --multi --ansi \
    --with-shell "bash -c" \
    --border rounded --border-label " 🔻 FEDORA-DUMP 🔻 " --border-label-pos 0:bottom \
    --header "$(bash "$SELF" --header)" --header-first \
    --prompt "Setup ❯ " --pointer "👉" --marker "✔" \
    --preview "bash $SELF_Q --preview {n}" \
    --preview-window "right,60%,wrap,follow,border-rounded" --preview-label " Details & output " \
    --bind "start:execute-silent(setsid bash $SELF_Q --task startup > /dev/null 2>&1 < /dev/null &)" \
    --bind "enter:transform(bash $SELF_Q --action {n} {+f} {q})" \
    --bind "esc:transform(bash $SELF_Q --escape)" \
    --bind "ctrl-l:execute-silent(bash $SELF_Q --toggle-log)+refresh-preview" \
    --color "border:6,label:5:bold,preview-border:6,preview-label:6:bold,header:7,prompt:6,pointer:5,marker:5" \
    --color "hl:5,hl+:5,fg+:15:bold,bg+:236" \
    > /dev/null || true
clear
echo "👋 Exiting..."
