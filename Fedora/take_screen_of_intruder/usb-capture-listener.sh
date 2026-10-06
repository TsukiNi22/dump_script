#!/bin/bash
# Check the usb & the lock state every second (see check-usb-and-capture.sh)
set -euo pipefail

while true; do
    /usr/local/bin/check-usb-and-capture.sh || true
    sleep 1
done
