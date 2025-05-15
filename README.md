# Dump Script for Fedora (for now)

### Script to automaticly set Pam Usb / Usb Lock & Power Shutdown / Screen Of Intruder / Dotfile / Package & App / Git

![image](https://github.com/user-attachments/assets/397c929e-ab0b-4994-8f5c-cf8edadd4b42)


Clone the repository:
```sh
git clone https://github.com/TsukiNi22/dump-script.git
```


Launch the installation:
```sh
cd dump_script
sudo make
```

## Content of Dotfile and Package & App

### Dotfile
`Neovim`, `Fastfetch`, `Zsh with Oh-My-Zsh`

### Package
`sl`, `csfml`, `binwalk`, `jhon-the-reaper`, `gibuster`, `hydra`

### App
`caido`, `vscode`, `qBittorent`, `vencord`, `sober`, `wireshark`, `Telegram`

## Get Information about usb id (`vendor-id` / `device-id`)

Use the command (`lsusb`) to get the following information:
```
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 003: ID 5986:211b Bison Electronics Inc. HD Webcam
Bus 001 Device 005: ID 8087:0033 Intel Corp. AX211 Bluetooth
Bus 001 Device 012: ID 04d9:a09f Holtek Semiconductor, Inc. E-Signal LUOM G10 Mechanical Gaming Mouse
Bus 001 Device 019: ID ffff:5678 USB Disk 2.0
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
```


For the `USB Disk 2.0` the vendor-id is `ffff` and the device-id is `5678`

The `vendor-id` and the `device-id` is used in Pam Usb / Usb Lock & Power Shutdown / Screen Of Intruder

The `cancel-vendor-id` and the `cancel-device-id` is used in Usb Lock & Power Shutdown to cancel the effect
