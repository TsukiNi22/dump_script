#!/bin/bash

# Color definition
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "[${BLUE}INFO${RESET}] Setup Of Usb-Lock System File"
command sh usb_lock_and_power_shutdown/set-file.sh $1 $2 $3 $4
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] Setup Of Usb-Lock System File"
    exit 0
fi
echo -e "[${GREEN}OK${RESET}] Setup Of Usb-Lock System File"
