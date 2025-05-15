#echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ════╗"
#command dnf install gum git ssh-keygen -y
#echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔺 ════╝"
#echo -e "[${GREEN}OK${RESET}] Download Package"

# binwalk / csfml / caido / jhon-the-reaper / gobuster / hydra / vscode / qBittorent / vencord / sober / wireshark / Telegram
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] "
    exit 1
fi
echo -e "[${GREEN}OK${RESET}] "
