#!/bin/bash

# Script to continuously check for USB status and capture screen if necessary
while true; do
    /usr/local/bin/check-usb-and-capture.sh
    sleep 1
done
