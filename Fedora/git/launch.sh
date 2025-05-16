echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ════╗"
command dnf install gum git inotifywait openssh -y
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

command sudo -u "$SUDO_USER" bash -c 'sh git/init.sh'
echo -e "[${GREEN}OK${RESET}] Init github repository"

command cp git/watch_delivery.sh /usr/local/bin/watch_delivery.sh
echo -e "[${GREEN}OK${RESET}] Setup of watch delivery script"
command cp git/watch_delivery.service tmp_watch_delivery.service
command sed -i "s/WHOAMI/$SUDO_USER/g" "tmp_watch_delivery.service"
echo -e "[${GREEN}OK${RESET}] Set of the file watch_delivery.service variable"
command mv tmp_watch_delivery.service /etc/systemd/system/watch_delivery.service 
echo -e "[${GREEN}OK${RESET}] Watch-Delivery service setup"

command systemctl daemon-reexec
command systemctl daemon-reload
echo -e "[${GREEN}OK${RESET}] Service reload"

command restorecon -v /etc/systemd/system/watch_delivery.service
command systemctl enable watch_delivery.service
command systemctl start watch_delivery.service
echo -e "[${GREEN}OK${RESET}] Watch-Delivery service started"
command systemctl enable sshd
command systemctl start sshd
echo -e "[${GREEN}OK${RESET}] Openssh service started"

command sudo -u "$SUDO_USER" bash -c "ssh-keygen -t ed25519 -C \"$email\" -f ~/.ssh/git"
echo -e "╔════ 🔻 [${CYAN}SHH-PUB${RESET}] 🔻 ════╗"
command sudo -u "$SUDO_USER" bash -c 'cat ~/.ssh/git.pub'
echo -e "╚════ 🔺 [${CYAN}SHH-PUB${RESET}] 🔺 ════╝"
echo -e "[${GREEN}OK${RESET}] Init ssh key"
