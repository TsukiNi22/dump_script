# Dump Script for Fedora

### Script to automatically set Pam Usb / Usb Lock & Power Shutdown / Screen Of Intruder / Dotfile / Package & App / Custom Package & Binary / AI / Git / Grub & Plymouth

![image](https://github.com/user-attachments/assets/397c929e-ab0b-4994-8f5c-cf8edadd4b42)

> [!WARNING]
> Fedora only, the script must be run with `sudo` from the user account (the config files belong to `$SUDO_USER`).

Clone the repository:
```bash
git clone https://github.com/TsukiNi22/dump-script.git ~/dump_script
```

Launch the installation:
```bash
cd ~/dump_script
sudo make
```

> [!TIP]
> Once the dotfiles are installed, the `dump` alias of the zshrc runs `sudo make` in this repository (path written by the Dotfile setup, wherever it was cloned).

> [!NOTE]
> Every setup is run from a `fzf` menu that stays open: the details of the hovered setup, the status and the end of
> the log of its last run are shown on the right (`ctrl-l`: full log). The usb keys can be chosen again from the
> menu (`Usb Keys`) and every setup can also be run alone: `sudo bash Fedora/<setup>/launch.sh`.

## Content of Dotfile, Package & App, Custom Package & AI

### Dotfile
| Config | Content |
| ------ | ------- |
| `Zsh` | `.zshrc` with `Oh-My-Zsh`, `zoxide`, aliases (git, make, cmake, docker...) |
| `Neovim` | `lazy.nvim`, `rose-pine`, `nvim-treesitter`, `nvim-cmp`, Xartania / Epitech headers & protos |
| `Fastfetch` | Random picture at each launch (`rdm_img.sh`, `chafa`) |
| `Tmux` | `zsh` as default shell |
| `Git` | Global ignore (`~/.config/git/ignore`) |

### Package
`gcc`, `clang`, `cmake`, `ccache`, `gtest`, `valgrind`, `docker`, `tmux`, `sl`, `csfml`, `binwalk`, `john`, `gobuster`,
`hydra`, `asciiquarium`, `gh`, `ripgrep`

### App
`vscode`, `qBittorrent`, `vesktop`, `sober`, `wireshark`, `Telegram`

### Custom Package & Binary
| Name | Content |
| ---- | ------- |
| [`libutils`](https://github.com/TsukiNi22/libutils) | TsukiNi22 rpm mirror, every build (optimized, debug, asan + headers) |
| `xstyle` | Coding style checker of the [skills](https://github.com/TsukiNi22/skills) repository (`~/.local/bin`) |

### AI
| Name | Content |
| ---- | ------- |
| `Claude Code` | Native installer (`~/.local/bin/claude`) |
| `Ollama` | Official installer (`/usr/local/bin/ollama`, `ollama.service`) |
| `Skills` | Every skill of the [skills](https://github.com/TsukiNi22/skills) repository in `~/.claude/skills` + their tools |
| `Skills context` | `CLAUDE.md`, `RTK.md`, hooks and `rtk` (branch `context` of the skills repository) |

### Git
Git user config, `~/delivery` & `~/personal_delivery`, `~/.ssh/git` key, then clone (https, push with ssh) any of:
| Repository | Folder |
| ---------- | ------ |
| `libutils`, `cpp_project_template` | `~/personal_delivery/cpp/` |
| `skills` | `~/personal_delivery/other/skills` (used by the Custom Package & AI setups) |
| Other links (one per line) | Chosen folder (default: `~/personal_delivery`) |

> [!CAUTION]
> The Pam Usb setup replaces `/etc/pam.d/system-auth` and `/etc/pam.d/password-auth` (managed by `authselect`):
> an `authselect apply-changes` puts back the default ones.

## Get Information about usb id (`vendor-id` / `device-id`)

The usb is chosen from the `lsusb` list in the menu, or written by hand with `Manual`:
```
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 003: ID 5986:211b Bison Electronics Inc. HD Webcam
Bus 001 Device 005: ID 8087:0033 Intel Corp. AX211 Bluetooth
Bus 001 Device 012: ID 04d9:a09f Holtek Semiconductor, Inc. E-Signal LUOM G10 Mechanical Gaming Mouse
Bus 001 Device 019: ID ffff:5678 USB Disk 2.0
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
```

For the `USB Disk 2.0` the `vendor-id` is `ffff` and the `device-id` is `5678`.

| Usb | Used by |
| --- | ------- |
| main (`vendor-id` / `device-id`) | Pam Usb, Usb Lock & Power Shutdown, Screen Of Intruder |
| cancel (`cancel-vendor-id` / `cancel-device-id`, optional) | Usb Lock & Power Shutdown: plugged -> the lock & shutdown are cancelled |

> [!NOTE]
> Without a plugged main usb, the 3 usb setups are shown with `(Deactivation)` and remove what they installed
> (Usb Lock & Power Shutdown: one of them or both).
