if [ ! -z $3 ] && [ ! -z $4 ]; then
    command cp usb-lock_power-shutdown.sh tmp_usb-lock_power-shutdown.sh
    command sed -i "s/CANCEL_VENDOR_IDV/$3/g" "tmp_usb-lock_power-shutdown.sh"
    command sed -i "s/CANCEL_DEVICE_IDV/$4/g" "tmp_usb-lock_power-shutdown.sh"
    command sed -i "s/WHOAMI/$SUDO_USER/g" "tmp_usb-lock_power-shutdown.sh"
    echo -e "[${GREEN}OK${RESET}] Set the variable of the detection script"
    command mv tmp_usb-lock_power-shutdown.sh /usr/local/bin/usb-lock_power-shutdown.sh
    echo -e "[${GREEN}OK${RESET}] Detection script setup"
else
    echo -e "[${YELLOW}WARNING${RESET}] Can't find a valid cancel usb (Cancel Usb: Not Setup)"
fi
