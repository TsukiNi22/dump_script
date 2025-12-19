echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ════╗"
command dnf install vi vim neovim fastfetch chafa zsh zoxide sl -y
echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔺 ════╝"
echo -e "[${GREEN}OK${RESET}] Download Package"

command sudo -u "$SUDO_USER" bash -c 'command mkdir -p ~/.config/nvim'
command sudo -u "$SUDO_USER" bash -c 'command cp -rf dotfile/nvim ~/.config/'
if [ ! $? -eq 0 ]; then
    echo -e "[${RED}FAILED${RESET}] Neovim config setup"
    exit 1
fi
echo -e "[${GREEN}OK${RESET}] Neovim config setup"

command sudo -u "$SUDO_USER" bash -c 'command fastfetch --gen-config-force'
if [ ! $? -eq 0 ]; then
    echo -e "[${RED}FAILED${RESET}] Fastfetch config generation"
    exit 1
fi
echo -e "[${GREEN}OK${RESET}] Fastfetch config generation"
command sudo -u "$SUDO_USER" bash -c 'command cp -rf dotfile/fastfetch ~/.config/'
if [ ! $? -eq 0 ]; then
    echo -e "[${RED}FAILED${RESET}] Fastfetch config setup"
    exit 1
fi
echo -e "[${GREEN}OK${RESET}] Fastfetch config setup"

command sudo -u "$SUDO_USER" bash -c 'command chsh -s $(which zsh)'
if [ ! $? -eq 0 ]; then
    echo -e "[${RED}SKIPED${RESET}] Zsh to default shell"
else
    echo -e "[${GREEN}OK${RESET}] Zsh is now the default shell"
fi
command sudo -u "$SUDO_USER" bash -c 'command cp dotfile/.zshrc ~/.zshrc'
if [ ! $? -eq 0 ]; then
    echo -e "[${RED}SKIPED${RESET}] Zshrc setup"
else
    echo -e "[${GREEN}OK${RESET}] Zshrc setup"
fi
command sudo -u "$SUDO_USER" bash -c 'command sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
if [ ! $? -eq 0 ]; then
    echo -e "[${RED}SKIPED${RESET}] Oh-My-Zsh setup"
else
    echo -e "[${GREEN}OK${RESET}] Oh-My-Zsh setup"
fi
