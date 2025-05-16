command cd take_screen_of_intruder/

command cp check-usb-and-capture.sh tmp_check-usb-and-capture.sh
command sed -i "s/VENDOR_IDV/$1/g" "tmp_check-usb-and-capture.sh"
command sed -i "s/DEVICE_IDV/$2/g" "tmp_check-usb-and-capture.sh"
command sed -i "s/WHOAMI/$SUDO_USER/g" "tmp_check-usb-and-capture.sh"
echo -e "[${GREEN}OK${RESET}] Set of the file check-usb-and-capture.sh variable"
command mv tmp_check-usb-and-capture.sh /usr/local/bin/check-usb-and-capture.sh
echo -e "[${GREEN}OK${RESET}] Usb-And-Capture file setup"

command cp usb-capture-listener.sh /usr/local/bin//usb-capture-listener.sh
echo -e "[${GREEN}OK${RESET}] Usb-Capture-Listener file setup"

command cp usb-capture.service tmp_usb-capture.service
command sed -i "s/WHOAMI/$SUDO_USER/g" "tmp_usb-capture.service"
echo -e "[${GREEN}OK${RESET}] Set of the file usb-capture.service variable"
command mv tmp_usb-capture.service /etc/systemd/system/usb-capture.service 
echo -e "[${GREEN}OK${RESET}] Usb-Capture service setup"

command systemctl daemon-reexec
command systemctl daemon-reload
echo -e "[${GREEN}OK${RESET}] Service reload"

command restorecon -v /etc/systemd/system/usb-capture.service
command systemctl enable usb-capture.service
command systemctl start usb-capture.service
echo -e "[${GREEN}OK${RESET}] Start of the Usb-Capture service"
