echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ════╗"
command dnf install aquarium dnf-plugins-core git curl wget -y
echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔺 ════╝"
echo -e "[${GREEN}OK${RESET}] Download Package"


echo -e "╔════ 🔻 [${CYAN}SETUP-RPM-FUSION${RESET}] 🔻 ════╗"
command dnf install -y \
https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
echo -e "╚════ 🔺 [${CYAN}SETUP-RPM-FUSION${RESET}] 🔺 ════╝"
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RED}] Setup RPM Fusion"
else
    echo -e "[${GREEN}OK${RESET}] Setup RPM Fusion"
fi

echo -e "╔═════ 🔻 [${CYAN}CYBER-SECURITY${RESET}] 🔻 ═════╗"
command dnf install binwalk gobuster hydra john -y
echo -e "╚═════ 🔺 [${CYAN}CYBER-SECURITY${RESET}] 🔺 ═════╝"
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RED}] Download cyber security package"
else
    echo -e "[${GREEN}OK${RESET}] Download cyber security package"
fi

echo -e "╔════ 🔻 [${CYAN}SETUP-WIRESHARK${RESET}] 🔻 ═════╗"
command dnf install wireshark -y \
&& command usermod -aG wireshark $SUDO_USER
echo -e "╚════ 🔺 [${CYAN}SETUP-WIRESHARK${RESET}] 🔺 ═════╝"
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RED}] Setup of wireshark"
else
    echo -e "[${GREEN}OK${RESET}] Setup of wireshark"
fi

echo -e "╔═════ 🔻 [${CYAN}DOWNLOAD-CSFML${RESET}] 🔻 ═════╗"
command dnf install CSFML CSFML-devel -y
echo -e "╚═════ 🔺 [${CYAN}DOWNLOAD-CSFML${RESET}] 🔺 ═════╝"
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RED}] Download of the csfml"
else
    echo -e "[${GREEN}OK${RESET}] Download of the csfml"
fi

echo -e "╔══════ 🔻 [${CYAN}VSCODE-SETUP${RESET}] 🔻 ══════╗"
command rpm --import https://packages.microsoft.com/keys/microsoft.asc \
&& command tee /etc/yum.repos.d/vscode.repo <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
command dnf install -y code
echo -e "╚══════ 🔺 [${CYAN}VSCODE-SETUP${RESET}] 🔺 ══════╝"
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RED}] Setup of vscode"
else
    echo -e "[${GREEN}OK${RESET}] Setup of vscode"
fi

echo -e "╔══════ 🔻 [${CYAN}CAIDO-SETUP${RESET}] 🔻 ═══════╗"
command flatpak install -y flathub io.caido.Caido
echo -e "╚══════ 🔺 [${CYAN}CAIDO-SETUP${RESET}] 🔺 ═══════╝"
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RED}] Setup of caido"
else
    echo -e "[${GREEN}OK${RESET}] Setup of caido"
fi

echo -e "╔══════ 🔻 [${CYAN}DESKTOP-APP${RESET}] 🔻 ═══════╗"
command dnf install -y telegram-desktop qbittorrent
command flatpak install -y flathub dev.vencord.Vesktop
echo -e "╚══════ 🔺 [${CYAN}DESKTOP-APP${RESET}] 🔺 ═══════╝"
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RED}] Download of the desktop app"
else
    echo -e "[${GREEN}OK${RESET}] Download of the desktop app"
fi
