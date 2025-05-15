DEVICE_INFO=$(lsusb | grep "$1:$2")

BUS=$(echo "$DEVICE_INFO" | awk '{print $2}')
DEVICE=$(echo "$DEVICE_INFO" | awk '{print $4}' | sed 's/://')

USB_INFORMATION_PATH="/dev/bus/usb/$BUS/$DEVICE"
USB_SYS_NAME="$(udevadm info --query=all --name="$USB_INFORMATION_PATH" | grep "M: " | sed "s/M: //g")"
USB_PATH="/sys/bus/usb/devices/$USB_SYS_NAME"

if [ ! -d "$USB_PATH" ]; then
    echo -e "[${RED}FAILED${RESET}] Can't acces to the usb"
    exit 1
fi

MODEL=$(cat "$USB_PATH/product" 2>/dev/null || echo "Inconnu")
VENDOR=$(cat "$USB_PATH/manufacturer" 2>/dev/null || echo "Inconnu")
SERIAL=$(cat "$USB_PATH/serial" 2>/dev/null || echo "Inconnu")

UUID="$3"
if [ -z "$UUID" ]; then
    DEVICE_BLOCK=$(lsblk -o SERIAL,UUID | grep -A 1 $SERIAL | tail -n 1 | sed "s/ //g")
    UUID=$(echo "$DEVICE_BLOCK" 2>/dev/null || echo "UUID non trouvé")
fi

command cd pam_usb/

command cp pam_usb.conf tmp_pam_usb.conf
command sed -i "s/VENDOR_NAME/$VENDOR/g" "tmp_pam_usb.conf"
command sed -i "s/MODEL_NAME/$MODEL/g" "tmp_pam_usb.conf"
command sed -i "s/SERIAL_NUMBER/$SERIAL/g" "tmp_pam_usb.conf"
command sed -i "s/VOLUME_UUID/$UUID/g" "tmp_pam_usb.conf"
command sed -i "s/WHOAMI/$SUDO_USER/g" "tmp_pam_usb.conf"
echo -e "[${GREEN}OK${RESET}] Set of the file pam_usb.conf variable"

command mv tmp_pam_usb.conf /etc/security/pam_usb.conf
echo -e "[${GREEN}OK${RESET}] Pam Usb config file setup"
command cp system-auth /etc/pam.d/
echo -e "[${GREEN}OK${RESET}] Pam Usb system-auth"
command cp password-auth /etc/pam.d/
echo -e "[${GREEN}OK${RESET}] Pam Usb password-auth"

