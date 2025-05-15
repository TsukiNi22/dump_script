#!/bin/bash

# Verification before any command
echo -e "═══════════════ [${CYAN}VERIFICATION${RESET}] ═══════════════"
if [[ $EUID -ne 0 ]]; then
    echo -e "[${RED}FAILED${RESET}] This script must be run as root (sudo su)"
    echo -e "═══════════════ [${CYAN}VERIFICATION${RESET}] ═══════════════"
    exit 1
fi
echo -e "[${GREEN}OK${RESET}] Script run as root"
echo -e "[${YELLOW}WARNING${RESET}] Proceed with caution"
if ! grep -q "Fedora" /etc/os-release; then
    echo -e "[${RED}FAILED${RESET}] This script must be run on Fedora"
    echo -e "═══════════════ [${CYAN}VERIFICATION${RESET}] ═══════════════"
    exit 1
fi
echo -e "[${GREEN}OK${RESET}] Script run on Fedora"

vendor_id=$(gum input --placeholder "Write vendor-id")
device_id=$(gum input --placeholder "Write device-id")
cancel_vendor_id=$(gum input --placeholder "Write cancel-vendor-id")
cancel_device_id=$(gum input --placeholder "Write cancel-device-id")
DEVICE_INFO=$(lsusb | grep "$cancel_vendor_id:$cancel_device_id")
if [ ! -z "$cancel_vendor_id" ] && [ ! -z "$cancel_device_id" ] && [ -z "$DEVICE_INFO" ]; then
    echo -e "[${RED}FAILED${RESET}] Can't find a usb with cancel-vendor-id and cancel-device-id"
elif [ -z "$cancel_vendor_id" ] || [ -z "$cancel_device_id" ]; then
    echo -e "[${BLUE}INFO${RESET}] The cancel usb is not set"
else
    echo -e "[${GREEN}OK${RESET}] Cancel usb have been found"
fi
DEVICE_INFO=$(lsusb | grep "$vendor_id:$device_id")
if [ ! -z "$vendor_id" ] && [ ! -z "$device_id" ] && [ -z "$DEVICE_INFO" ]; then
    echo -e "[${RED}FAILED${RESET}] Can't find a usb with vendor-id and device-id"
elif [ -z "$vendor_id" ] || [ -z "$device_id" ]; then
    echo -e "[${BLUE}INFO${RESET}] The usb is not set"
else
    echo -e "[${GREEN}OK${RESET}] Usb have been found"
fi
echo -e "═══════════════ [${CYAN}VERIFICATION${RESET}] ═══════════════"

# Update of the actual package
echo -e "══════════════════ [${CYAN}UPDATE${RESET}] ══════════════════"
echo -e "╔═════ 🔻 [${CYAN}UPDATE-PACKAGE${RESET}] 🔻 ═════╗"
command dnf update -y
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] Update Package"
    echo -e "╚═════ 🔺 [${CYAN}UPDATE-PACKAGE${RESET}] 🔺 ═════╝"
    echo -e "══════════════════ [${CYAN}UPDATE${RESET}] ══════════════════"
    exit 1
fi
echo -e "╚═════ 🔺 [${CYAN}UPDATE-PACKAGE${RESET}] 🔺 ═════╝"
echo -e "[${GREEN}OK${RESET}] Update Package"
echo -e "══════════════════ [${CYAN}UPDATE${RESET}] ══════════════════"

echo -e "══════════════ [${CYAN}INITIALISATION${RESET}] ══════════════"
echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ════╗"
command dnf install gum git ssh-keygen -y
echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔺 ════╝"
echo -e "[${GREEN}OK${RESET}] Download Package"
echo -e "══════════════ [${CYAN}INITIALISATION${RESET}] ══════════════"

MENU=("Pam Usb"
    "Usb Lock & Power Shutdown"
    "Screen Of Intruder"
    "Dotfile"
    "Package & App"
    "Git"
    "Quit")

if [ -z "$vendor_id" ] || [ -z "$device_id" ] || [ -z "$DEVICE_INFO" ]; then
    MENU=("Dotfile"
        "Package & App"
        "Git"
        "Quit")
fi

while true; do
    CHOICE=$(gum choose --cursor "👉" --header "Setup Menu:" "${MENU[@]}")

    case "$CHOICE" in
        "Pam Usb")
            echo -e "═════════════════ [${CYAN}PAM-USB${RESET}] ══════════════════"
            command sh pam_usb/launch.sh $vendor_id $cancel_vendor_id
            if [ $? -eq 1 ]; then
                echo -e "[${RED}FAILED${RESET}] Pam Usb"
                echo -e "═════════════════ [${CYAN}PAM-USB${RESET}] ══════════════════"
                exit 1
            fi
            echo -e "═════════════════ [${CYAN}PAM-USB${RESET}] ══════════════════"
            ;;

        "Usb Lock & Power Shutdown")
            echo -e "═════════ [${CYAN}USB_LOCK-POWER_SHUTDOWN${RESET}] ══════════"
            command sh usb_lock_and_power_shutdown/launch.sh $vendor_id $device_id $cancel_vendor_id $cancel_device_id
            if [ $? -eq 1 ]; then
                echo -e "[${RED}FAILED${RESET}] USB Lock & Shutdown"
                echo -e "═════════ [${CYAN}USB_LOCK-POWER_SHUTDOWN${RESET}] ══════════"
                exit 1
            fi
            echo -e "═════════ [${CYAN}USB_LOCK-POWER_SHUTDOWN${RESET}] ══════════"
            ;;

        "Screen Of Intruder")
            echo -e "═════════ [${CYAN}TAKE-SCREEN-OF-INTRUDER${RESET}] ══════════"
            command sh take_screen_of_intruder/launch.sh $vendor_id $device_id
            if [ $? -eq 1 ]; then
                echo -e "[${RED}FAILED${RESET}] Screen of intruder"
                echo -e "═════════ [${CYAN}TAKE-SCREEN-OF-INTRUDER${RESET}] ══════════"
                exit 1
            fi
            echo -e "═════════ [${CYAN}TAKE-SCREEN-OF-INTRUDER${RESET}] ══════════"
            ;;

        "Dotfile")
            echo -e "═════════════════ [${CYAN}DOTFILE${RESET}] ══════════════════"
            command sh dotfile/launch.sh
            if [ $? -eq 1 ]; then
                echo -e "[${RED}FAILED${RESET}] Dotfile"
                echo -e "═════════════════ [${CYAN}DOTFILE${RESET}] ══════════════════"
                exit 1
            fi
            echo -e "═════════════════ [${CYAN}DOTFILE${RESET}] ══════════════════"
            ;;

        "Package & App")
            echo -e "═══════════════ [${CYAN}PACKAGE-APP${RESET}] ════════════════"
            command sh package_app/launch.sh
            if [ $? -eq 1 ]; then
                echo -e "[${RED}FAILED${RESET}] Package & App"
                echo -e "═══════════════ [${CYAN}PACKAGE-APP${RESET}] ════════════════"
                exit 1
            fi
            echo -e "═══════════════ [${CYAN}PACKAGE-APP${RESET}] ════════════════"
            ;;

        "Git")
            echo -e "═══════════════════ [${CYAN}GIT${RESET}] ════════════════════"
            command sh git/launch.sh
            if [ $? -eq 1 ]; then
                echo -e "[${RED}FAILED${RESET}] Git"
                echo -e "═══════════════════ [${CYAN}GIT${RESET}] ════════════════════"
                exit 1
            fi
            echo -e "═══════════════════ [${CYAN}GIT${RESET}] ════════════════════"
            ;;

        "Quit")
            echo -e "👋 Exiting..."
            break
            ;;
        *)
            echo -e "👋 Exiting..."
            break
            ;;
    esac
done
