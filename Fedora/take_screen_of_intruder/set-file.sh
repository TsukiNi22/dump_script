#!/bin/bash

command cd take_screen_of_intruder/

echo -e "[${BLUE}INFO${RESET}] Set of the file check-usb-and-capture.sh variable"
command cp check-usb-and-capture.sh tmp_check-usb-and-capture.sh
command sed -i "s/VENDOR_IDV/$1/g" "tmp_check-usb-and-capture.sh"
command sed -i "s/DEVICE_IDV/$2/g" "tmp_check-usb-and-capture.sh"
command sed -i "s/WHOAMI/$SUDO_USER/g" "tmp_check-usb-and-capture.sh"
echo -e "[${GREEN}OK${RESET}] Set of the file check-usb-and-capture.sh variable"
command mv tmp_check-usb-and-capture.sh /usr/local/bin/check-usb-and-capture.sh
echo -e "[${GREEN}OK${RESET}] Usb-And-Capture file setup"

echo -e "[${BLUE}INFO${RESET}] Set of the file usb-capture.service variable"
command cp usb-capture.service tmp_usb-capture.service
command sed -i "s/WHOAMI/$SUDO_USER/g" "tmp_usb-capture.service"
echo -e "[${GREEN}OK${RESET}] Set of the file usb-capture.service variable"
command mv tmp_usb-capture.service usb-capture.service 
echo -e "[${GREEN}OK${RESET}] Usb-Capture service setup"

echo -e "[${BLUE}INFO${RESET}] Usb-Capture-Listener file setup"
command cp usb-capture-listener.sh tmp_usb-capture-listener.sh
command mv tmp_usb-capture-listener.sh /etc/systemd/system/usb-capture-listener.sh
echo -e "[${GREEN}OK${RESET}] Usb-Capture-Listener file setup"

