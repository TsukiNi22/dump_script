# Dump Script for Linux

### Script to automatically set Pam Usb / Usb Lock & Power Shutdown / Screen Of Intruder / Dotfile / Package & App / Custom Package & Binary / AI / Git / Grub & Plymouth

![image](https://github.com/user-attachments/assets/397c929e-ab0b-4994-8f5c-cf8edadd4b42)

> [!WARNING]
> The script must be run with `sudo` from the user account (the config files belong to `$SUDO_USER`).

| Family | Distributions (`ID` / `ID_LIKE` of `/etc/os-release`) | Packages |
| ------ | ------------------------------------------------------ | -------- |
| fedora-like | Fedora, RHEL, CentOS, Rocky, Alma... | `dnf` |
| debian-like | Debian, Ubuntu, Mint, Pop!_OS... | `apt` |
| arch-like | Arch, Manjaro, EndeavourOS... | `pacman` |

> [!NOTE]
> The package names are translated for each family, a package missing from the repositories of the distribution is
> reported and skipped (or installed another way: `gum` from the Charm repository, `asciiquarium` from its sources...).

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
> A loading screen runs the system update (fixed title, logs below), then everything runs in one `fzf` window: a
> setup runs in the background with its output shown live on the right (details, status and output of its last
> run, `ctrl-l`: whole output), and its questions are asked in the list of the window. Every setup can also be run
> alone (`gum` prompts, `fzf` without gum): `sudo bash Linux/<setup>/launch.sh`.

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
| [`libutils`](https://github.com/TsukiNi22/libutils) | TsukiNi22 rpm / deb mirror (built from the sources on arch), every build (optimized, debug, asan + headers) |
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

> [!NOTE]
> The `~/.ssh/git` key is an `ed25519` key (the strongest type of OpenSSH and GitHub, no post-quantum signature key
> exists for ssh yet) or an `ed25519-sk` key on a FIDO2 security key, protected by a passphrase (256 KDF rounds).
> The quantum resistance comes from the key exchange: the github host of `~/.ssh/config` only allows the
> post-quantum hybrids `mlkem768x25519-sha256` and `sntrup761x25519-sha512`.

| Repository | Folder |
| ---------- | ------ |
| `libutils`, `cpp_project_template` | `~/personal_delivery/cpp/` |
| `skills` | `~/personal_delivery/other/skills` (used by the Custom Package & AI setups) |
| `docker-image` | `~/personal_delivery/other/docker-image` |
| Other links (one per line) | Chosen folder (default: `~/personal_delivery`) |

> [!CAUTION]
> The Pam Usb setup requires the usb key (password AND usb) in the auth stack: a marked block at the start of
> `/etc/pam.d/system-auth` (+ `password-auth` on fedora-like, rebuilt by `authselect` first) or a `pam-auth-update`
> profile on debian-like. It is only enabled when `pam_usb.so` is installed with all its libraries.

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
> The usb keys are optional (`Usb Keys` in the menu). Without a plugged main usb, the 3 usb setups are marked
> `(usb key needed)` and propose to choose it when they start, or to only deactivate what they installed
> (Usb Lock & Power Shutdown: one of them or both).
