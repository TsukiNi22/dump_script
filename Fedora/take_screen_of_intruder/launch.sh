echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ════╗"
command dnf install gum fswebcam -y
echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔺 ════╝"
echo -e "[${GREEN}OK${RESET}] Download Package"

DEVICE_INFO=$(lsusb | grep "$1:$2")
if [ ! -s "$1" ] && [ ! -z "$2" ] && [ ! -z "$DEVICE_INFO" ]; then
    CHOICE=$(gum choose "Activate" "Desactivate")
fi
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$DEVICE_INFO" ] || [ "$CHOICE" = "Desactivate" ]; then
    command rm -f /usr/local/bin/check-usb-and-capture.sh
    echo -e "[${GREEN}OK${RESET}] Usb-And-Capture remove"
    command rm -f /usr/local/bin/usb-capture-listener.sh
    echo -e "[${GREEN}OK${RESET}] Usb-Capture-Listener remove"
    command rm -f /etc/systemd/system/usb-capture.service 
    echo -e "[${GREEN}OK${RESET}] Usb-Capture service remove"
    command systemctl daemon-reexec
    command systemctl daemon-reload
    echo -e "[${GREEN}OK${RESET}] Service reload"
    exit 0
fi

command sh take_screen_of_intruder/set-file.sh $1 $2
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] Setup Of Take Screen Of Intruder File"
    exit 1
fi
