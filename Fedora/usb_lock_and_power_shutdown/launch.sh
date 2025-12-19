command cd usb_lock_and_power_shutdown/

get_status() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        echo "Activation"
    else
        echo "Desactivation"
    fi
}

USB_RULE="/etc/udev/rules.d/80-usb-lock.rules"
POWER_RULE="/etc/udev/rules.d/80-power-shutdown.rules"

STATUS_USB=$(get_status "$USB_RULE")
STATUS_POWER=$(get_status "$POWER_RULE")

echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ════╗"
command dnf install gum -y
echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔺 ════╝"
echo -e "[${GREEN}OK${RESET}] Download Package"

DEVICE_INFO=$(lsusb | grep "$1:$2")

if [[ -n "$1" && -n "$2" && -n "$DEVICE_INFO" ]]; then
    CHOICE=$(gum choose \
        "USB Lock ($STATUS_USB)" \
        "Power Shutdown ($STATUS_POWER)" \
        "Both (Activation)" \
        "Both (Desactivation)")
        "Cancel"
else
    CHOICE="Both (Desactivation)"
fi

if [[ "$CHOICE" == "Cancel" ]]; then
    exit 0
fi

if [[ "$CHOICE" == "Both (Desactivation)" || "$CHOICE" == "USB Lock (Desactivation)" || "$CHOICE" == "Power Shutdown (Desactivation)" ]]; then
    if [[ "$CHOICE" == "Both (Desactivation)" || ( "$CHOICE" == "USB Lock (Desactivation)" && ! -f "$POWER_RULE" ) || ( "$CHOICE" == "Power Shutdown (Desactivation)" && ! -f "$USB_RULE" ) ]]; then
        command rm -f /usr/local/bin/usb-lock.sh
        echo -e "[${GREEN}OK${RESET}] Detection script removed"
    fi

    if [[ "$CHOICE" == "Both (Desactivation)" || "$CHOICE" == "USB Lock (Desactivation)" ]]; then
        command rm -f "$USB_RULE"
        echo -e "[${GREEN}OK${RESET}] USB Lock rules removed"
    fi

    if [[ "$CHOICE" == "Both (Desactivation)" || "$CHOICE" == "Power Shutdown (Desactivation)" ]]; then
        command rm -f "$POWER_RULE"
        echo -e "[${GREEN}OK${RESET}] Power rules disabled"
    fi

    exit 0
fi

if [[ -z "$1" || -z "$2" || -z "$DEVICE_INFO" ]]; then
    echo -e "[${RED}FAILED${RESET}] Insufficiant information to setup the USB & Power detection script"
    exit 1
fi

command sh set-file.sh "$1" "$2" "$3" "$4"
if [[ $? -eq 1 ]]; then
    echo -e "[${RED}FAILED${RESET}] Setup of the USB & Power detection script"
    exit 1
fi
echo -e "[${GREEN}OK${RESET}] Setup of the USB & Power detection script"

if [[ "$CHOICE" == "Both (Activation)" || "$CHOICE" == "USB Lock (Activation)" ]]; then
    command cp 80-usb-lock.rules tmp_80-usb-lock.rules
    command sed -i "s/VENDOR_IDV/$1/g" "tmp_80-usb-lock.rules"
    command sed -i "s/DEVICE_IDV/$2/g" "tmp_80-usb-lock.rules"
    echo -e "[${GREEN}OK${RESET}] Set the variable for the USB Lock rule"
    command mv tmp_80-usb-lock.rules "$USB_RULE"
    echo -e "[${GREEN}OK${RESET}] USB Lock rules file setup"
fi

if [[ "$CHOICE" == "Both (Activation)" || "$CHOICE" == "Power Shutdown (Activation)" ]]; then
    command cp -f 80-power-shutdown.rules "$POWER_RULE"
    echo -e "[${GREEN}OK${RESET}] Power Shutdown rules file setup"
fi
