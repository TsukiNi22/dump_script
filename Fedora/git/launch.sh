echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ════╗"
command dnf install gum git ssh-keygen -y
echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔺 ════╝"
echo -e "[${GREEN}OK${RESET}] Download Package"

name=$(command gum input --placeholder "Write your github username")
email=$(command gum input --placeholder "Write your github email")

command git config --global user.name $name
command git config --global user.email $email
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] Configuration of the git information"
    exit 1
fi

command sh git/init.sh
echo -e "[${GREEN}OK${RESET}] Init github repository"

command ssh-keygen -t ed25519 -C $email -f ~/.ssh/git
echo -e "╔════ 🔻 [${CYAN}SHH-PUB${RESET}] 🔻 ════╗"
command cat ~/.ssh/git.pub
echo -e "╚════ 🔺 [${CYAN}SHH-PUB${RESET}] 🔺 ════╝"
echo -e "[${GREEN}OK${RESET}] Init ssh key"
