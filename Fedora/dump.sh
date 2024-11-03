#!/bin/bash

# Color definition
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESET="\e[0m"

<<EOF
echo -e "[${GREEN}OK${RESET}] Script run on Fedora"
echo -e "[${RED}ERROR${RESET}] An error occurred"
echo -e "[${YELLOW}WARNING${RESET}] Proceed with caution"
echo -e "[${BLUE}INFO${RESET}] Starting the process"
echo -e "[${MAGENTA}NOTE${RESET}] Please check the logs"
echo -e "[${CYAN}UPDATE${RESET}] System is up to date"
EOF

# Verification before any command
echo -e "-----------[${CYAN}VERIFICATION${RESET}]-----------"
if [[ $EUID -ne 0 ]]; then
    echo -e "[${RED}FAILED${RESET}] This script must be run as root (sudo su)"
    echo -e "-----------[${CYAN}VERIFICATION${RESET}]-----------"
    exit 0
fi
echo -e "[${GREEN}OK${RESET}] Script run as root"
echo -e "[${YELLOW}WARNING${RESET}] Proceed with caution"
if ! grep -q "Fedora" /etc/os-release; then
    echo -e "[${RED}FAILED${RESET}] This script must be run on Fedora"
    echo -e "-----------[${CYAN}VERIFICATION${RESET}]-----------"
    exit 0
fi
echo -e "[${GREEN}OK${RESET}] Script run on Fedora"
echo -e "-----------[${CYAN}VERIFICATION${RESET}]-----------"

# Update of the actual package
echo -e "--------------[${CYAN}UPDATE${RESET}]--------------"
echo -e "[${BLUE}INFO${RESET}] Update Package"
echo -e "↓↓---[${CYAN}DOWLOADING${RESET}]---↓↓"
command dnf update -y
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] Update Package"
    echo -e "↑↑---[${CYAN}DOWLOADING${RESET}]---↑↑"
    echo -e "--------------[${CYAN}UPDATE${RESET}]--------------"
    exit 0
fi
echo -e "↑↑---[${CYAN}DOWLOADING${RESET}]---↑↑"
echo -e "[${GREEN}OK${RESET}] Update Package"
echo -e "--------------[${CYAN}UPDATE${RESET}]--------------"

# Pam usb part
echo -e "--------------[${CYAN}PAM-USB${RESET}]--------------"
command sh pam_usb/launch.sh
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] Pam Usb"
    echo -e "--------------[${CYAN}PAM-USB${RESET}]--------------"
    exit 0
fi
echo -e "--------------[${CYAN}PAM-USB${RESET}]--------------"

# Usb Lock part
echo -e "------[${CYAN}USB_LOCK-POWER_SHUTDOWN${RESET}]------"
command sh usb_lock_and_power_shutdown/launch.sh
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] Pam Usb"
    echo -e "------[${CYAN}USB_LOCK-POWER_SHUTDOWN${RESET}]------"
    exit 0
fi
echo -e "------[${CYAN}USB_LOCK-POWER_SHUTDOWN${RESET}]------"
