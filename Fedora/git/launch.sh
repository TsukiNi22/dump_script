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

name=$(gum input --placeholder "Write your github username" --value "$(user_git_config user.name || true)")
email=$(gum input --placeholder "Write your github email" --value "$(user_git_config user.email || true)")
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
    run_as_user ssh-keygen -q -t ed25519 -C "$email" -f "$SSH_KEY"
    ok "Init ssh key"
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
