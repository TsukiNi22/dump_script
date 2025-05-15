command cd usb_lock_and_power_shutdown/

if [ ! -z $3 ] && [ ! -z $4 ]; then
    command cp usb-lock.sh tmp_usb-lock.sh
    command sed -i "s/CANCEL_VENDOR_IDV/$3/g" "tmp_usb-lock.sh"
    command sed -i "s/CANCEL_DEVICE_IDV/$4/g" "tmp_usb-lock.sh"
    command sed -i "s/WHOAMI/$SUDO_USER/g" "tmp_usb-lock.sh"
    echo -e "[${GREEN}OK${RESET}] Set of the file usb-lock.sh variable"
    command mv tmp_usb-lock.sh /usr/local/bin/usb-lock.sh
    echo -e "[${GREEN}OK${RESET}] Usb-Lock service setup"
else
    echo -e "[${YELLOW}WARNING${RESET}] Can't find a valid cancel usb (Cancel Usb: Not Setup)"
fi

command cp 80-usb-lock.rules tmp_80-usb-lock.rules
command sed -i "s/VENDOR_IDV/$1/g" "tmp_80-usb-lock.rules"
command sed -i "s/DEVICE_IDV/$2/g" "tmp_80-usb-lock.rules"
echo -e "[${GREEN}OK${RESET}] Set of the file 80-usb-lock.rules variable"
command mv tmp_80-usb-lock.rules /etc/udev/rules.d/80-usb-lock.rules
echo -e "[${GREEN}OK${RESET}] Rules file setup"
