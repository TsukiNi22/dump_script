#!/bin/bash

command cd pam_usb/
command git clone https://github.com/mcdope/pam_usb.git
command make -C pam_usb/ > /dev/null
command make -C pam_usb/ install > /dev/null
command rm -rf pam_usb/
command cd ..
