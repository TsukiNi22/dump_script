#!/bin/bash
# Usage: sudo bash git/launch.sh
# Configure git for the user, create the delivery folders and the github ssh key
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

SSH_DIR="$USER_HOME/.ssh"
SSH_KEY="$SSH_DIR/git"
SSH_CONFIG="$SSH_DIR/config"
SSH_KDF_ROUNDS=256 # Rounds of the passphrase derivation (slows down the brute force of a stolen key)
# Post-quantum key exchange only with github (ML-KEM / NTRU Prime hybrids): no classic fallback
SSH_PQ_KEX="mlkem768x25519-sha256,sntrup761x25519-sha512"

install_packages git gum openssh-clients || exit 1

# =========================
# Git config
# =========================
# The global config belongs to the user (not to root)
user_git_config() {
    run_as_user git config --global "$@"
}

if ! name=$(ask_input "Github username:" "$(user_git_config user.name || true)") \
    || ! email=$(ask_input "Github email:" "$(user_git_config user.email || true)"); then
    skipped "Git setup"
    exit 0
fi
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
# Ed25519: the strongest key type of OpenSSH & github (no post-quantum signature key exists for ssh yet),
# protected by a passphrase typed on the terminal (hidden), -sk = on a FIDO2 security key
if [[ -f "$SSH_KEY" ]]; then
    ok "Ssh key already exists ($SSH_KEY)"
else
    key_type=$(ask_choose "Type of the git ssh key:" \
        "ed25519 (passphrase)" "ed25519-sk (FIDO2 security key plugged)") || key_type=""
    case "$key_type" in
        "ed25519 (passphrase)") key_args=(-t ed25519) ;;
        "ed25519-sk"*) key_args=(-t ed25519-sk -O resident -O verify-required) ;;
        *) skipped "Ssh key"; key_args=() ;;
    esac
    if [[ ${#key_args[@]} -gt 0 ]]; then
        if run_on_tty "Passphrase of the git ssh key (strongly recommended)" \
            sudo -u "$SUDO_USER" -H ssh-keygen "${key_args[@]}" -a "$SSH_KDF_ROUNDS" -C "$email" -f "$SSH_KEY"; then
            ok "Init ssh key ($(ssh-keygen -l -f "$SSH_KEY.pub" | awk '{print $NF}'))"
        else
            failed "Init ssh key"
        fi
    fi
fi

# The key has a custom name -> ssh only uses it with this host block (rewritten to keep it up to date)
if [[ -f "$SSH_CONFIG" ]]; then
    run_as_user sed -i '/^# >>> dump_script github >>>$/,/^# <<< dump_script github <<<$/d' "$SSH_CONFIG"
fi
run_as_user tee -a "$SSH_CONFIG" > /dev/null <<SSH
# >>> dump_script github >>>
Host github.com
    HostName github.com
    User git
    IdentityFile $SSH_KEY
    IdentitiesOnly yes
    AddKeysToAgent yes
    KexAlgorithms $SSH_PQ_KEX
    HostKeyAlgorithms ssh-ed25519
# <<< dump_script github <<<
SSH
chmod 600 "$SSH_CONFIG"
ok "Github host in $SSH_CONFIG (post-quantum key exchange)"

if [[ -f "$SSH_KEY.pub" ]]; then
    box_open "SSH-PUB"
    cat "$SSH_KEY.pub"
    box_close "SSH-PUB"
fi
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
