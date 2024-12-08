#!/bin/bash

echo -e "[${BLUE}INFO${RESET}] Download Package"
echo -e "↓↓---[${CYAN}DOWLOADING${RESET}]---↓↓"
command sh take_screen_of_intruder/install-package.sh
echo -e "↑↑---[${CYAN}DOWLOADING${RESET}]---↑↑"
echo -e "[${GREEN}OK${RESET}] Download Package"

echo -e "[${BLUE}INFO${RESET}] Setup Of Take Screen Of Intruder File"
command sh take_screen_of_intruder/set-file.sh $1 $2
if [ $? -eq 1 ]; then
    echo -e "[${RED}INFO${RESET}] Setup Of Take Screen Of Intruder File"
    exit 0
fi
echo -e "[${BLUE}INFO${RESET}] Start of the Usb-Capture service"
command systemctl daemon-reload
command systemctl enable usb-capture.service
command systemctl start usb-capture.service
echo -e "[${GREEN}OK${RESET}] Start of the Usb-Capture service"
echo -e "[${BLUE}INFO${RESET}] Setup Of Take Screen Of Intruder File"
