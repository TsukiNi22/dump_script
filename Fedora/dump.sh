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
echo -e "[${BLUE}INFO${RESET}] Start Verification:"
if [[ $EUID -ne 0 ]]; then
   echo -e "[${RED}FAILED${RESET}] This script must be run as root" 1>&2
   exit 0
fi
echo -e "[${GREEN}OK${RESET}] Script run as root"
echo -e "[${YELLOW}WARNING${RESET}] Proceed with caution"

if ! grep -q "Fedora" /etc/os-release; then
    echo -e "[${RED}FAILED${RESET}] This script must be run on Fedora";
    exit 0
fi
echo -e "[${GREEN}OK${RESET}] Script run on Fedora"

# Update of the actual package
echo -e "--------------[${CYAN}UPDATE${RESET}]--------------"
echo -e "[${BLUE}INFO${RESET}] Update Package"
command dnf update -y
echo -e "--------------[${CYAN}UPDATE${RESET}]--------------"

echo -e "--------------[${CYAN}PAM-USB${RESET}]--------------"
command sh pam_usb/launch.sh
echo -e "--------------[${CYAN}PAM-USB${RESET}]--------------"
