#!/bin/bash
# Usage: sudo bash git/launch.sh
# Configure git for the user, create the delivery folders and the github ssh key
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

SSH_DIR="$USER_HOME/.ssh"
SSH_KEY="$SSH_DIR/git"
SSH_CONFIG="$SSH_DIR/config"

install_packages git gum openssh-clients || exit 1

# =========================
# Git config
# =========================
# The global config belongs to the user (not to root)
user_git_config() {
    run_as_user git config --global "$@"
}

name=$(ask_input "Github username:" "$(user_git_config user.name || true)") || name=""
email=$(ask_input "Github email:" "$(user_git_config user.email || true)") || email=""
if [[ -z "$name" || -z "$email" ]]; then
    failed "The github username and email are required"
    exit 1
fi

user_git_config user.name "$name"
user_git_config user.email "$email"
user_git_config push.autoSetupRemote true
user_git_config core.editor nvim
user_git_config init.defaultBranch main
ok "Configuration of the git information"

# =========================
# Delivery folders
# =========================
for dir in "$USER_HOME/personal_delivery" "$USER_HOME/delivery"; do
    if [[ -d "$dir/.git" ]]; then
        ok "$dir already setup"
        continue
    fi
    run_as_user mkdir -p "$dir"
    run_as_user git -C "$dir" init -q
    ok "Setup of $dir"
done

# =========================
# Ssh key
# =========================
run_as_user mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"
if [[ -f "$SSH_KEY" ]]; then
    ok "Ssh key already exists ($SSH_KEY)"
else
    # No passphrase (no terminal in the menu): add one with ssh-keygen -p -f ~/.ssh/git
    run_as_user ssh-keygen -q -t ed25519 -N "" -C "$email" -f "$SSH_KEY" < /dev/null
    ok "Init ssh key (without passphrase)"
fi

# The key has a custom name -> ssh only uses it with this host block
if ! grep -q "# >>> dump_script github >>>" "$SSH_CONFIG" 2> /dev/null; then
    run_as_user tee -a "$SSH_CONFIG" > /dev/null <<SSH

# >>> dump_script github >>>
Host github.com
    HostName github.com
    User git
    IdentityFile $SSH_KEY
    IdentitiesOnly yes
# <<< dump_script github <<<
SSH
    chmod 600 "$SSH_CONFIG"
    ok "Github host added to $SSH_CONFIG"
fi

box_open "SSH-PUB"
cat "$SSH_KEY.pub"
box_close "SSH-PUB"
info "Add this key on https://github.com/settings/keys"

# =========================
# Repositories
# =========================
# Clone with https (works before the key is added on github), push with ssh: clone_repo <url> <folder>
clone_repo() {
    local url="$1"
    local dest="$2"
    local push_url="$url"

    if [[ -d "$dest/.git" ]]; then
        ok "$dest already cloned"
        return 0
    fi
    if [[ "$url" =~ ^https://github\.com/(.+)$ ]]; then
        push_url="git@github.com:${BASH_REMATCH[1]}"
    fi
    run_as_user mkdir -p "$(dirname "$dest")"
    if run_as_user git clone -q "$url" "$dest" && run_as_user git -C "$dest" remote set-url --push origin "$push_url"; then
        ok "Clone of $url ($dest)"
    else
        failed "Clone of $url"
        return 1
    fi
}

CHOICES=$(ask_choose --multi "Repositories to clone:" \
    "libutils" "skills" "cpp_project_template" "docker-image" "Other links") || CHOICES=""
mapfile -t SELECTED <<< "$CHOICES"
status=0
for choice in "${SELECTED[@]}"; do
    case "$choice" in
        "libutils"|"cpp_project_template")
            clone_repo "https://github.com/$GITHUB_USER/$choice.git" "$USER_HOME/personal_delivery/cpp/$choice" || status=1 ;;
        "skills")
            clone_repo "https://github.com/$GITHUB_USER/skills.git" "$SKILLS_DIR" || status=1 ;;
        "docker-image")
            clone_repo "https://github.com/$GITHUB_USER/docker-image.git" "$USER_HOME/personal_delivery/other/docker-image" \
                || status=1 ;;
        "Other links")
            links=$(ask_write "Repository links:") || links=""
            dest_dir=$(ask_input "Folder of the clones:" "$USER_HOME/personal_delivery") || dest_dir=""
            while read -r link; do
                [[ -z "$link" ]] && continue
                name=$(basename "$link" .git)
                clone_repo "$link" "${dest_dir:-$USER_HOME/personal_delivery}/$name" < /dev/null || status=1
            done <<< "$links"
            ;;
    esac
done
exit "$status"
