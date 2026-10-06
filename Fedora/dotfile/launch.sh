#!/bin/bash
# Usage: sudo bash dotfile/launch.sh
# Install the user config: zsh + oh-my-zsh, neovim, fastfetch, tmux, git ignore
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils.sh"

REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
OMZ_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"

# =========================
# Packages
# =========================
# tree-sitter-cli + gcc: build of the nvim-treesitter parsers, util-linux-user: chsh
install_packages vim-enhanced neovim git gcc tree-sitter-cli fastfetch chafa \
    zsh zoxide sl tmux curl util-linux-user || exit 1

# =========================
# Zsh
# =========================
# Before the zshrc copy: the installer would replace it otherwise
if [[ -d "$USER_HOME/.oh-my-zsh" ]]; then
    ok "Oh-My-Zsh already installed"
elif run_as_user env RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL "$OMZ_URL")" "" --unattended; then
    ok "Oh-My-Zsh setup"
else
    failed "Oh-My-Zsh setup"
    exit 1
fi

if [[ -f "$USER_HOME/.zshrc" ]] && ! cmp -s "$SCRIPT_DIR/.zshrc" "$USER_HOME/.zshrc"; then
    run_as_user cp "$USER_HOME/.zshrc" "$USER_HOME/.zshrc.bak"
    info "Old zshrc saved in ~/.zshrc.bak"
fi
run_as_user mkdir -p "$USER_HOME/.zsh/completions"
run_as_user cp "$SCRIPT_DIR/.zshrc" "$USER_HOME/.zshrc"

# The dump alias points to this repository, wherever it was cloned
run_as_user sed -i "s|^alias dump=.*|alias dump='\\\\sudo make -C \"$(escape_sed "$REPO_DIR")\"'|" "$USER_HOME/.zshrc"
ok "Zshrc setup (dump -> $REPO_DIR)"

if chsh -s "$(command -v zsh)" "$SUDO_USER" > /dev/null; then
    ok "Zsh is now the default shell"
else
    skipped "Zsh to default shell"
fi

# =========================
# Config files
# =========================
run_as_user mkdir -p "$USER_HOME/.config/git"
run_as_user cp -rf "$SCRIPT_DIR/nvim" "$USER_HOME/.config/"
ok "Neovim config setup"

# config.jsonc is generated from config_save.jsonc by rdm_img.sh (fastfetch alias)
run_as_user cp -rf "$SCRIPT_DIR/fastfetch" "$USER_HOME/.config/"
run_as_user chmod +x "$USER_HOME/.config/fastfetch/rdm_img.sh"
ok "Fastfetch config setup"

run_as_user cp "$SCRIPT_DIR/.tmux.conf" "$USER_HOME/.tmux.conf"
ok "Tmux config setup"

run_as_user cp "$SCRIPT_DIR/git/ignore" "$USER_HOME/.config/git/ignore"
ok "Git global ignore setup"
