#!/bin/bash

# Variables
CANCEL_USB_VENDOR_ID="CANCEL_VENDOR_IDV"
CANCEL_USB_MODEL_ID="CANCEL_DEVICE_IDV"

# Récupérer la session de l'utilisateur
session=$(loginctl | grep 'WHOAMI' | awk '{print $1;}')
SCREEN_LOCKED=$(loginctl show-session $(loginctl | grep 'WHOAMI' | awk '{print $1}') -p LockedHint | cut -d'=' -f2)
# Vérifier l'argument passé au script
if ! lsusb | grep -q "${CANCEL_USB_VENDOR_ID}:${CANCEL_USB_MODEL_ID}"; then
	if [ "$1" == "lock" ]; then
	    # Verrouiller la session et mettre en veille
	    loginctl lock-session ${session}
	    systemctl suspend
	elif [ "$1" == "shutdown" ] ; then
	    # Éteindre le PC
	    systemctl poweroff
	fi
fi
