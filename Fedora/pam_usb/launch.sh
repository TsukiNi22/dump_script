#!/bin/bash

echo -e "[${BLUE}INFO${RESET}] Download Package"
echo -e "↓↓---[${CYAN}DOWLOADING${RESET}]---↓↓"
command sh pam_usb/install-package.sh
echo -e "↑↑---[${CYAN}DOWLOADING${RESET}]---↑↑"
echo -e "[${GREEN}OK${RESET}] Download Package"
echo -e "[${BLUE}INFO${RESET}] Download Pam Usb"
echo -e "↓↓---[${CYAN}DOWLOADING${RESET}]---↓↓"
command sh pam_usb/install-pam_usb.sh
echo -e "↑↑---[${CYAN}DOWLOADING${RESET}]---↑↑"
echo -e "[${GREEN}OK${RESET}] Download Pam Usb"

echo -e "[${BLUE}INFO${RESET}] Setup Of Pam Usb"
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

echo -e "[${BLUE}INFO${RESET}] Setup Of Pam Usb System File"
command sh pam_usb/set-file.sh $1 $2 $3
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] Setup Of Pam Usb System File"
    exit 0
fi
echo -e "[${GREEN}OK${RESET}] Setup Of Pam Usb System File"
