command sh usb_lock_and_power_shutdown/set-file.sh $1 $2 $3 $4
if [ $? -eq 1 ]; then
    echo -e "[${RED}FAILED${RESET}] Setup Of Usb-Lock System File"
    exit 1
fi
echo -e "[${GREEN}OK${RESET}] Setup Of Usb-Lock System File"
