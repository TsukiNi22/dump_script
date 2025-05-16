GRUB="grub"
if [ ! -d /boot/$GRUB ]; then
	GRUB="grub2"
fi
echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ═════╗"
command dnf install git plymouth dracut $GRUB -y
echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔺 ═════╝"
echo -e "[${GREEN}OK${RESET}] Download Package"

repo_name=$(gum input --placeholder "Write link to a grub theme repository")
command rm -rf grub_setup
echo -e "╔═══ 🔻 [${CYAN}DOWNLOAD-GRUB-THEME${RESET}] 🔻 ═══╗"
command git clone $repo_name grub_setup
echo -e "╚═══ 🔺 [${CYAN}DOWNLOAD-GRUB-THEME${RESET}] 🔺 ═══╝"
if [ -d grub_setup ]; then
    echo -e "[${GREEN}OK${RESET}] Download Grub theme"
    command cd grub_setup/
    if [ -f install.sh ]; then
        echo -e "╔═ 🔻 [${CYAN}INSTALLATION-GRUB-THEME${RESET}] 🔻 ═╗"
        command sh install.sh
        echo -e "╚═ 🔺 [${CYAN}INSTALLATION-GRUB-THEME${RESET}] 🔺 ═╝"
        echo -e "[${GREEN}OK${RESET}] Installation Grub theme"
        command cd ..
        command rm -rf grub_setup
        echo -e "[${GREEN}OK${RESET}] Grub setup"
    else
        echo -e "[${BLUE}INFO${RESET}] install.sh not found in the given repository"
        echo -e "[${RED}SKIPED${RESET}] Installation Grub setup"
        command cd ..
        command rm -rf grub_setup
    fi
else
    echo -e "[${RED}FAILED${RESET}] Download Grub theme"
fi

first_dir=$(find grub_plymouth/plymouth_theme/ -mindepth 1 -maxdepth 1 -type d | head -n 1)
plymouth_theme_name=$(basename "$first_dir")
echo -e "[${BLUE}INFO${RESET}] Plymouth theme used is stored in $PWD/grub_plymouth/plymouth_theme/*"
command cp -r grub_plymouth/plymouth_theme/$plymouth_theme_name /usr/share/plymouth/themes/
echo -e "[${GREEN}OK${RESET}] Plymouth themes cloned"
command plymouth-set-default-theme $plymouth_theme_name
echo -e "[${GREEN}OK${RESET}] Plymouth themes selected"
echo -e "[${BLUE}INFO${RESET}] Start regenration of the initramfs"
command plymouth-set-default-theme -R $plymouth_theme_name
echo -e "[${GREEN}OK${RESET}] Regenration of the initramfs"
echo -e "[${GREEN}OK${RESET}] Plymouth setup"
