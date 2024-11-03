#!/bin/bash

# Color definition
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "[${BLUE}INFO${RESET}] Download Package"
command sh pam_usb/install-package.sh
echo -e "[${GREEN}OK${RESET}] Download Package"
echo -e "[${BLUE}INFO${RESET}] Download Pam Usb"
command sh pam_usb/install-pam_usb.sh
echo -e "[${GREEN}OK${RESET}] Download Pam Usb"

echo -e "[${BLUE}INFO${RESET}] Setup Of Pam Usb"
if ! pamusb-conf --add-device Usb ; then
    echo -e "[${RED}FAILED${RESET}] Of the command 'pamusb-conf --add-device Usb'"
    exit 1
fi

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
command cd pam_usb/
command cp pam_usb.conf /etc/security/
echo -e "[${GREEN}OK${RESET}] Pam Usb config file setup"
command cp system-auth /etc/pam.d/
echo -e "[${GREEN}OK${RESET}] Pam Usb system-auth"
command cp password-auth /etc/pam.d/
echo -e "[${GREEN}OK${RESET}] Pam Usb password-auth"
echo -e "[${GREEN}OK${RESET}] Setup Of Pam Usb System File"
