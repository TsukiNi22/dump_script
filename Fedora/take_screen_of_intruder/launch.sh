echo -e "╔════ 🔻 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔻 ════╗"
command dnf install fswebcam -y
echo -e "╚════ 🔺 [${CYAN}DOWNLOAD-PACKAGE${RESET}] 🔺 ════╝"
echo -e "[${GREEN}OK${RESET}] Download Package"

command sh take_screen_of_intruder/set-file.sh $1 $2
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] Setup Of Take Screen Of Intruder File"
    exit 1
fi
command systemctl daemon-reload
command systemctl enable usb-capture.service
command systemctl start usb-capture.service
echo -e "[${GREEN}OK${RESET}] Start of the Usb-Capture service"
echo -e "[${GREEN}OK${RESET}] Setup Of Take Screen Of Intruder File"
