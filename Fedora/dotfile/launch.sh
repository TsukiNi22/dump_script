#echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ════╗"
#command dnf install gum git ssh-keygen -y
#echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔺 ════╝"
#echo -e "[${GREEN}OK${RESET}] Download Package"

# nvim / fastfestch / zsh
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] "
    exit 1
fi
echo -e "[${GREEN}OK${RESET}] "
