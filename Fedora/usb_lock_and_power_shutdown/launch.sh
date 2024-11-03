#!/bin/bash

# Color definition
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "[${BLUE}INFO${RESET}] Setup Of The File"
command cd usb_lock_and_power_shutdown/
command cp 80-usb-lock.rules /etc/udev/rules.d/
echo -e "[${GREEN}OK${RESET}] Usb Lock Rule"
command cp usb-lock.sh /usr/local/bin/
echo -e "[${GREEN}OK${RESET}] Usb Lock sh"
echo -e "[${GREEN}OK${RESET}] Setup Of The File"
