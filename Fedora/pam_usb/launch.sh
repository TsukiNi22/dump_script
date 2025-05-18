echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ════╗"
dnf install gum gcc make vim git python3 -y
echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔺 ════╝"
echo -e "[${GREEN}OK${RESET}] Download Package"

DEVICE_INFO=$(lsusb | grep "$1:$2")
if [ ! -s "$1" ] && [ ! -z "$2" ] && [ ! -z "$DEVICE_INFO" ]; then
    CHOICE=$(gum choose "Activate" "Desactivate")
fi
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$DEVICE_INFO" ] || [ "$CHOICE" = "Desactivate" ]; then
    command cp pam_usb/disabled_system-auth /etc/pam.d/system-auth
    echo -e "[${GREEN}OK${RESET}] Desactivation of system-auth"
    command cp pam_usb/disabled_password-auth /etc/pam.d/password-auth
    echo -e "[${GREEN}OK${RESET}] Desactivation of password-auth"
    exit 0
fi

echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PAM-USB${RESET}] 🔻 ════╗"
command cd pam_usb/
command rm -rf pam_usb/
command git clone https://github.com/mcdope/pam_usb.git
command make -C pam_usb/ > /dev/null
command make -C pam_usb/ install > /dev/null
command rm -rf pam_usb/
command cd ..
echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PAM-USB${RESET}] 🔺 ════╝"
echo -e "[${GREEN}OK${RESET}] Download Pam Usb"

#OUTPUT=$(command pamusb-conf --add-device Usb)
if echo "$OUTPUT" | grep -q "No devices detected"; then
    echo -e "[${RED}INFO${RESET}] $OUTPUT"
    echo -e "[${RED}FAILED${RESET}] The command 'pamusb-conf --add-device Usb' failed."
    exit 1
fi
if [ $? -ne 0 ]; then
    echo -e "[${RED}FAILED${RESET}] The command 'pamusb-conf --add-device Usb' failed."
fi

#OUTPUT=$(command pamusb-conf --add-user "$(whoami)")
if [ $? -ne 0 ]; then
    echo -e "[${RED}INFO${RESET}] $OUTPUT"
    echo -e "[${RED}FAILED${RESET}] Of the command 'pamusb-conf --add-user $(whoami)'"
    exit 1
fi
echo -e "[${GREEN}OK${RESET}] Setup Of Pam Usb"

command sh pam_usb/set-file.sh $1 $2
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] Setup Of Pam Usb System File"
    exit 1
fi
echo -e "[${GREEN}OK${RESET}] Setup Of Pam Usb System File"
