# dump-script

Interactive setup of a fresh Fedora machine: usb security (pam_usb, usb lock & power shutdown, picture of the
intruder), dotfiles, packages & apps, git and grub/plymouth themes. Every setup is optional and chosen from a
`gum` menu.

![image](https://github.com/user-attachments/assets/397c929e-ab0b-4994-8f5c-cf8edadd4b42)

### Table of Contents
 - [Quick Setup](#quick-setup)
 - [Setups](#setups)
 - [Usb ids](#usb-ids)
 - [Layout](#layout)

## Quick Setup
> [!WARNING]
> Fedora only, the script must be run with `sudo` from the user account (the config files belong to `$SUDO_USER`).

```bash
git clone https://github.com/TsukiNi22/dump-script.git ~/dump_script
cd ~/dump_script
sudo make
```

> [!TIP]
> Once the dotfiles are installed, the `dump` alias of the zshrc runs `sudo make -C ~/dump_script`.

## Setups
| Setup | Content |
| ----- | ------- |
| Pam Usb | Build [pam_usb](https://github.com/mcdope/pam_usb), password **and** main usb required to log in (`system-auth`, `password-auth`) |
| Usb Lock & Power Shutdown | udev rules: lock & suspend when the main usb is removed, power off when the charger is unplugged (cancelled by the cancel usb) |
| Screen Of Intruder | `usb-capture` service: webcam picture in `~/Images/Intruder_Picture` when the screen is locked without the main usb |
| Dotfile | `zsh` + Oh-My-Zsh (`.zshrc`), `neovim` (lazy, treesitter, cmp), `fastfetch` (random picture), `tmux`, git global ignore |
| Package & App | RPM Fusion, Flathub, dev tools (`gcc`, `clang`, `cmake`, `ccache`, `gtest`, `valgrind`, `docker`), `CSFML`, `binwalk`, `gobuster`, `hydra`, `john`, `wireshark`, `vscode`, `telegram`, `qbittorrent`, `vesktop`, `sober` |
| Git | Git user config, `~/delivery` & `~/personal_delivery` repositories, `~/.ssh/git` key + github host in `~/.ssh/config` |
| Grub & Plymouth | Grub theme from a repository with an `install.sh` (optional), plymouth theme of `Fedora/grub_plymouth/plymouth_theme` |

> [!NOTE]
> Without a plugged main usb, the 3 usb setups are shown with `(Deactivation)` and remove what they installed.

> [!CAUTION]
> The pam setup replaces `/etc/pam.d/system-auth` and `/etc/pam.d/password-auth` (managed by `authselect`):
> an `authselect apply-changes` puts back the default ones.

## Usb ids
The usb ids (`vendor-id:device-id`) are chosen from the `lsusb` list (or written by hand with `Manual`):
```
Bus 001 Device 019: ID ffff:5678 USB Disk 2.0
```
For the `USB Disk 2.0` the vendor-id is `ffff` and the device-id is `5678`.

| Usb | Used by |
| --- | ------- |
| main | Pam Usb, Usb Lock & Power Shutdown, Screen Of Intruder |
| cancel (optional) | Usb Lock & Power Shutdown: plugged -> the lock & shutdown are cancelled |

## Layout
| Path | Content |
| ---- | ------- |
| `Fedora/dump.sh` | Menu (usb selection then the setups) |
| `Fedora/utils.sh` | Shared helpers (logs, `install_packages`, `run_as_user`, ...) |
| `Fedora/<setup>/launch.sh` | One setup, can be run alone: `sudo bash Fedora/<setup>/launch.sh` |
| `Fedora/dotfile/` | Copy of the config files (`.zshrc`, `nvim/`, `fastfetch/`, `.tmux.conf`, `git/ignore`) |
