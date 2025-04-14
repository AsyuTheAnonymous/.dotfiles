# Overview of My Dotfiles

This repository contains my personal dotfiles, which are configuration files that customize the look and feel of my operating system and applications.

## Desktop Contents:

*   `Hosts/Desktop/desktop.nix`: This file likely contains the NixOS configuration for my desktop environment.
*   `Hosts/Desktop/hardware-configuration.nix`: This file likely contains the hardware configuration for my desktop.

## OS Map:

```
.
├── flake.lock
├── flake.nix
├── Hosts
│   ├── Desktop
│   │   ├── desktop.nix
│   │   └── hardware-configuration.nix
│   ├── Environments
│   │   ├── Hyprland
│   │   │   ├── configs
│   │   │   │   ├── ghostty
│   │   │   │   │   └── config
│   │   │   │   ├── neofetch
│   │   │   │   │   └── config.conf
│   │   │   │   ├── rofi
│   │   │   │   │   ├── catppuccin-mocha.rasi
│   │   │   │   │   └── config.rasi
│   │   │   │   ├── starship
│   │   │   │   │   └── starship.toml
│   │   │   │   └── waybar
│   │   │   │       ├── config
│   │   │   │       ├── Minimal
│   │   │   │       │   ├── config
│   │   │   │       │   └── style.css
│   │   │   │       ├── Old
│   │   │   │       │   ├── config.jsonc
│   │   │   │       │   ├── macchiato.css
│   │   │   │       │   └── style.css
│   │   │   │       ├── Solo
│   │   │   │       │   ├── config
│   │   │   │       │   └── style.css
│   │   │   │       └── style.css
│   │   │   ├── hypridle.conf
│   │   │   ├── hyprland.conf
│   │   │   ├── hypr.nix
│   │   │   └── hyprpaper.conf
│   │   ├── kde
│   │   │   └── kde.nix
│   │   ├── lumina
│   │   │   └── lumi.nix
│   │   └── wayfire
│   │       ├── wayfire.ini
│   │       └── wayfire.nix
│   └── Laptop
│       ├── hardware-configuration.nix
│       └── laptop.nix
├── Hypervisor
│   └── Virt-Manager
│       └── virt.nix
├── Modules
│   ├── Common
│   │   ├── common.nix
│   │   ├── Packages
│   │   │   ├── AI
│   │   │   │   └── Open-Webui
│   │   │   │       ├── package.nix
│   │   │   │       └── webui.nix
│   │   │   ├── Automation
│   │   │   │   └── automation.nix
│   │   │   ├── Browsers
│   │   │   │   └── brave.nix
│   │   │   ├── Editors
│   │   │   │   ├── Emacs
│   │   │   │   │   └── emacs.nix
│   │   │   │   └── Vscode
│   │   │   │       └── vscode.nix
│   │   │   ├── Flatpak
│   │   │   │   └── flatpak.nix
│   │   │   ├── Hacking
│   │   │   │   └── tools.nix
│   │   │   ├── Helpers
│   │   │   │   └── nh.nix
│   │   │   ├── Mail
│   │   │   │   └── Proton
│   │   │   │       └── mail.nix
│   │   │   ├── Optimization
│   │   │   │   ├── Cleaner
│   │   │   │   │   └── auto.nix
│   │   │   │   └── Nix
│   │   │   │       └── nix.nix
│   │   │   ├── packages.nix
│   │   │   ├── Recording
│   │   │   │   └── obs.nix
│   │   │   ├── Remote
│   │   │   │   └── Parsec
│   │   │   │       └── parsec.nix
│   │   │   └── Terminals
│   │   │       └── Ghostty
│   │   │           └── ghostty.nix
│   │   └── Stylix
│   │       ├── desktop.nix
│   │       └── laptop.nix
│   ├── Custom
│   │   ├── custom.nix
│   │   └── Msty
│   │       └── default.nix
│   ├── Desktop
│   │   ├── AI
│   │   ├── Browsers
│   │   ├── desktop.nix
│   │   ├── Editors
│   │   ├── Gaming
│   │   │   └── gaming.nix
│   │   ├── Packages
│   │   ├── Tablet
│   │   │   └── tablet.nix
│   │   └── Unstable
│   │       └── unstable.nix
│   └── Laptop
│       ├── Browsers
│       ├── Editors
│       ├── laptop.nix
│       └── Packages
├── OS-Map.txt
├── readme.md
├── Scripts
│   ├── Common
│   ├── Desktop
│   └── Laptop
├── System
│   ├── Common
│   │   ├── audio
│   │   │   └── pipewire.nix
│   │   ├── bootloader
│   │   │   ├── grub.nix
│   │   │   └── sysd.nix
│   │   ├── common.nix
│   │   ├── fonts
│   │   │   └── nerd.nix
│   │   ├── greeter
│   │   │   └── sddm.nix
│   │   ├── network
│   │   │   ├── bluetooth.nix
│   │   │   ├── config.nix
│   │   │   ├── firewall.nix
│   │   │   ├── locale.nix
│   │   │   ├── nm.nix
│   │   │   └── ssh.nix
│   │   ├── shell
│   │   │   └── zsh.nix
│   │   ├── themes
│   │   │   └── vesk-themes
│   │   │       ├── FVUI.theme.css
│   │   │       ├── neutron.theme.css
│   │   │       ├── SoftX.theme.css
│   │   │       └── Synthesis.theme.css
│   │   └── wallpapers
│   │       ├── abstract.png
│   │       ├── ascii-cat.png
│   │       ├── cave.jpg
│   │       ├── coffee.jpg
│   │       ├── cute.jpg
│   │       ├── level.png
│   │       ├── pusheen.jpg
│   │       └── solo.jpg
│   ├── Desktop
│   │   ├── desktop.nix
│   │   ├── drives
│   │   │   └── drives.nix
│   │   └── gpu
│   │       └── nvidia.nix
│   ├── ISO
│   │   ├── configuration.nix
│   │   └── iso.nix
│   └── Laptop
│       └── laptop.nix
└── Users
    ├── Desktop
    │   └── asyu.nix
    ├── Github
    │   └── git.nix
    ├── Home
    │   ├── Common
    │   │   └── Gtk
    │   │       └── gtk.nix
    │   ├── Desktop
    │   │   └── desktop.nix
    │   └── Laptop
    │       └── laptop.nix
    └── Laptop
        └── asyu.nix

87 directories, 94 files
```

This OS map provides a tree-like structure of the files and directories in my dotfiles repository.

## Explanation of Key Directories and Modules:

*   **Hosts:** Contains configurations specific to different machines (Desktop, Laptop) and environments (Hyprland, kde, lumina, wayfire).
*   **Modules:** This directory contains NixOS modules designed for efficient troubleshooting, application development and testing, and website development and testing. These modules outline the applications and configurations used on a day-to-day basis, ensuring absolute efficiency.

    *   **Automation:** This module installs automation tools such as `ansible`, `sshpass`, and `jenkins`.
    *   **Recording:** This module installs `obs-studio` for screen recording and streaming.
    *   **Optimization/Nix:** This module configures Nix settings for optimization, including download buffer size, HTTP connections, maximum jobs, cores, and auto-optimise store.
*   **System:** Contains system-level configurations, such as audio, bootloader, fonts, network, and shell settings.
*   **Users:** Contains user-specific configurations.

This `readme.md` provides an overview of my dotfiles repository, highlighting the key directories and the purpose of the NixOS modules.