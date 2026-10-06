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
GREY=$'\033[90m'
BOLD=$'\033[1m'
RESET=$'\033[0m'

# Same colors in the gum prompts (ANSI 5 = magenta, 6 = cyan)
export GUM_CHOOSE_CURSOR="👉 "
export GUM_CHOOSE_CURSOR_FOREGROUND="5"
export GUM_CHOOSE_HEADER_FOREGROUND="6"
export GUM_CHOOSE_SELECTED_FOREGROUND="5"
export GUM_INPUT_CURSOR_FOREGROUND="5"
export GUM_INPUT_PROMPT_FOREGROUND="6"
export GUM_INPUT_PROMPT="❯ "
export GUM_WRITE_CURSOR_FOREGROUND="5"
export GUM_WRITE_HEADER_FOREGROUND="6"

# =========================
# Display
# =========================
DISPLAY_WIDTH=60 # Width of the sections & boxes

# Print <count> times <char>
repeat() {
    local line=""
    local i

    for ((i = 0; i < $2; i++)); do
        line+="$1"
    done
    printf '%s' "$line"
}

# Center a text between <char> on <total> columns: center <char> <total> <text display width> <text>
center() {
    local left=$((($2 - $3) / 2))
    local right=$(($2 - $3 - left))

    echo "$(repeat "$1" "$left")$4$(repeat "$1" "$right")"
}

# =========================
# Logs
# =========================
# Tags of 8 columns -> the messages are aligned
ok() {
    echo "[  ${GREEN}OK${RESET}  ] $*"
}

failed() {
    echo "[${RED}${BOLD}FAILED${RESET}] $*" >&2
}

skipped() {
    echo "[ ${YELLOW}SKIP${RESET} ] $*"
}

warning() {
    echo "[ ${YELLOW}WARN${RESET} ] $*"
}

info() {
    echo "[ ${BLUE}INFO${RESET} ] $*"
}

# Section title of a setup: ════ [ NAME ] ════
# In the menu (DUMP_LOG set) sections & boxes are markers drawn by the preview at its own width
section() {
    if [[ -n "${DUMP_LOG:-}" ]]; then
        echo "@@SECTION@@ $1"
        return 0
    fi
    echo
    center "═" "$DISPLAY_WIDTH" $((${#1} + 6)) " [ ${BOLD}${CYAN}$1${RESET} ] "
}

# Box around the output of a command: ╔══ 🔻 [ NAME ] 🔻 ══╗ ... ╚══ 🔺 [ NAME ] 🔺 ══╝
# (an emoji takes 2 columns, the corners are outside of the centered part)
box_open() {
    if [[ -n "${DUMP_LOG:-}" ]]; then
        echo "@@BOX@@ $1"
        return 0
    fi
    echo "╔$(center "═" $((DISPLAY_WIDTH - 2)) $((${#1} + 12)) " 🔻 [ ${CYAN}$1${RESET} ] 🔻 ")╗"
}

box_close() {
    if [[ -n "${DUMP_LOG:-}" ]]; then
        echo "@@BOXEND@@ $1"
        return 0
    fi
    echo "╚$(center "═" $((DISPLAY_WIDTH - 2)) $((${#1} + 12)) " 🔺 [ ${CYAN}$1${RESET} ] 🔺 ")╝"
}

# =========================
# Questions
# =========================
# In the menu (dump.sh): the question is shown in the fzf window (--listen API) and the answer written back
# by the menu in $DUMP_STATE_DIR/ask. Run alone: gum prompts.
ASK_POLL_DELAY=0.2 # Seconds between two checks of the answer

in_menu() {
    [[ -n "${FZF_PORT:-}" && -n "${DUMP_STATE_DIR:-}" ]]
}

# Send actions to the fzf menu
fzf_post() {
    curl -s -XPOST "localhost:$FZF_PORT" -d "$1" > /dev/null
}

# Show a question in the menu and wait for its answer: menu_ask <kind> <header> <query> <actions> [option...]
# kind = choose | multi | input | write, prints the answer, return 1 when cancelled
menu_ask() {
    local kind="$1"
    local header="$2"
    local query="$3"
    local actions="$4"
    local dir="$DUMP_STATE_DIR/ask"
    shift 4

    command mkdir -p "$dir"
    rm -f "$dir/answer" "$dir/status"
    : > "$dir/options"
    if [[ $# -gt 0 ]]; then
        printf '%s\n' "$@" > "$dir/options"
    fi
    printf '%s' "$query" > "$dir/query"
    echo "$kind" > "$dir/kind"
    echo "${BOLD}${CYAN}$header${RESET}" > "$dir/header"
    case "$kind" in
        choose) echo "${GREY}enter validate • esc cancel${RESET}" >> "$dir/header" ;;
        multi) echo "${GREY}tab toggle • enter validate • esc cancel${RESET}" >> "$dir/header" ;;
        input) echo "${GREY}type • enter validate • esc cancel${RESET}" >> "$dir/header" ;;
        write) echo "${GREY}values separated by spaces • enter validate${RESET}" >> "$dir/header" ;;
    esac
    echo "answer" > "$DUMP_STATE_DIR/mode"
    fzf_post "reload-sync(cat $dir/options)+transform-header(cat $dir/header)+change-prompt(Answer ❯ )+transform-query(cat $dir/query)+deselect-all+first+refresh-preview"
    # Separate request: the list must be reloaded before moving / selecting in it
    if [[ -n "$actions" ]]; then
        sleep "$ASK_POLL_DELAY"
        fzf_post "${actions#+}"
    fi

    while [[ ! -f "$dir/status" ]]; do
        sleep "$ASK_POLL_DELAY"
    done
    if [[ "$(cat "$dir/status")" != "ok" ]]; then
        return 1
    fi
    cat "$dir/answer"
}

# Choose options: ask_choose [--multi] [--selected <a,b>] <header> <option...> (one answer per line)
# A "Cancel" option is always added (last): choosing it = esc, return 1
ask_choose() {
    local multi=false
    local selected=""
    local header
    local actions=""
    local answer
    local i

    while [[ "${1:-}" == --* ]]; do
        case "$1" in
            --multi) multi=true; shift ;;
            --selected) selected="$2"; shift 2 ;;
        esac
    done
    header="$1"
    shift
    if [[ "${!#}" != "Cancel" ]]; then
        set -- "$@" "Cancel"
    fi

    if ! in_menu; then
        if [[ "$multi" == true ]]; then
            answer=$(gum choose --no-limit --selected="$selected" --header "$header" "$@") || return 1
        else
            answer=$(gum choose --header "$header" "$@") || return 1
        fi
    elif [[ "$multi" == false ]]; then
        answer=$(menu_ask choose "$header" "" "" "$@") || return 1
    else
        # Pre-selection: move on each selected option and select it
        for ((i = 1; i <= $#; i++)); do
            if [[ ",$selected," == *",${!i},"* ]]; then
                actions+="+pos($i)+select"
            fi
        done
        answer=$(menu_ask multi "$header" "" "$actions+first" "$@") || return 1
    fi
    if [[ -z "$answer" ]] || grep -qx "Cancel" <<< "$answer"; then
        return 1
    fi
    echo "$answer"
}

# Ask a text: ask_input <header> [default]
ask_input() {
    if ! in_menu; then
        gum input --placeholder "$1" --value "${2:-}"
        return
    fi
    menu_ask input "$1" "${2:-}" ""
}

# Ask several values (one per line in the answer): ask_write <header>
ask_write() {
    if ! in_menu; then
        gum write --height=10 --placeholder "$1 (one per line, ctrl+d to validate)"
        return
    fi
    menu_ask write "$1" "" ""
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

# Run a step inside a box and report it, return 1 on failure: run_step <NAME> <label> <command...>
# (set -e is ignored inside the command -> chain its commands with &&)
run_step() {
    local name="$1"
    local label="$2"
    local status=0
    shift 2

    box_open "$name"
    "$@" || status=1
    box_close "$name"
    if [[ "$status" -ne 0 ]]; then
        failed "$label"
        return 1
    fi
    ok "$label"
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

# Run the setup.sh of the skills repository as the user (local clone of the Git setup, managed clone otherwise)
skills_setup() {
    if [[ -f "$SKILLS_DIR/setup.sh" ]]; then
        run_as_user bash "$SKILLS_DIR/setup.sh" "$@"
    else
        run_as_user bash -c 'curl -fsSL "$0" | bash -s -- "$@"' "$SKILLS_SETUP_URL" "$@"
    fi
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

# =========================
# Repositories
# =========================
GITHUB_USER="TsukiNi22"
SKILLS_DIR="$USER_HOME/personal_delivery/other/skills" # Clone of the Git setup (base repositories)
SKILLS_SETUP_URL="https://raw.githubusercontent.com/$GITHUB_USER/skills/main/setup.sh"
