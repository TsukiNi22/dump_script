echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ════╗"
command dnf install gum fswebcam -y
echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔺 ════╝"
echo -e "[${GREEN}OK${RESET}] Download Package"

DEVICE_INFO=$(lsusb | grep "$1:$2")
if [ ! -s "$1" ] && [ ! -z "$2"] && [ ! -z "$DEVICE_INFO" ]; then
    CHOICE=$(gum choose "Activate" "Desactivate")
fi
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$DEVICE_INFO" ] || [ "$CHOICE" = "Desactivate" ]; then
    exit 0
fi

command sh take_screen_of_intruder/set-file.sh $1 $2
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] Setup Of Take Screen Of Intruder File"
    exit 1
fi
