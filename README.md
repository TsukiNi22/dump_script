# Dump Script for Fedora/Ubuntu

### Script to automaticly set pam_usb / usb security / alias / git delivery / coding-style ...


Go to the folder who correspond to your os

Run the following command with root permission (`sudo su`):


Clone the repository:
```sh
git clone https://github.com/Epitech/coding-style-checker.git
```


Launch the installation with your corresponding information (vendor-id, device-id, ...):
```sh
make ARG="'vendor-id' 'device-id' 'cancel-vendor-id' 'cancel-device-ie'" FORCE="'forced-uuid'"
```


Use the command (`lsusb`) to get the following information:
```
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 003: ID 5986:211b Bison Electronics Inc. HD Webcam
Bus 001 Device 005: ID 8087:0033 Intel Corp. AX211 Bluetooth
Bus 001 Device 012: ID 04d9:a09f Holtek Semiconductor, Inc. E-Signal LUOM G10 Mechanical Gaming Mouse
Bus 001 Device 019: ID ffff:5678 USB Disk 2.0
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
```


Here the vendor-id is (`ffff`)

Here the device-id is (`5678`)


The `vendor-id` and the `device-id` is for the usb used for the connection / lock and other

The `cancel-vendor-id` and the `cancel-device-id` is for the usb used for cancel lock action and shutdown action of usb and power


The `force-uuid` is when your usb can't detect by file sytem, you need to write by yourself the part
