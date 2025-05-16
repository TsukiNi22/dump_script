echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ════╗"
command dnf install gum -y
echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔺 ════╝"
echo -e "[${GREEN}OK${RESET}] Download Package"

DEVICE_INFO=$(lsusb | grep "$1:$2")
if [ ! -s "$1" ] && [ ! -z "$2" ] && [ ! -z "$DEVICE_INFO" ]; then
    CHOICE=$(gum choose "Activate" "Desactivate")
fi
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$DEVICE_INFO" ] || [ "$CHOICE" = "Desactivate" ]; then
    command rm -f /usr/local/bin/usb-lock.sh
    echo -e "[${GREEN}OK${RESET}] Usb-Lock script remove"
    command cp -f usb_lock_and_power_shutdown/disabled_80-usb-lock.rules /etc/udev/rules.d/80-usb-lock.rules
    echo -e "[${GREEN}OK${RESET}] Rules remove"
    exit 0
fi

command sh usb_lock_and_power_shutdown/set-file.sh $1 $2 $3 $4
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] Setup Of Usb-Lock System File"
    exit 1
fi
echo -e "[${GREEN}OK${RESET}] Setup Of Usb-Lock System File"
