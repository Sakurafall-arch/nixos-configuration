# nixos-configuration

My NixOS flake configuration for **T2 MacBook**, featuring tmpfs root, Home Manager, and a Chinese-optimized desktop environment.

## Features

- **Flake-based** — modular, reproducible NixOS configuration
- **tmpfs root** — `/` mounted as tmpfs, clean state every reboot; persistence on Btrfs subvolumes (`/nix`, `/var`, `/etc`, `/home`)
- **T2 MacBook support** — Apple T2 hardware firmware and drivers via `nixos-hardware`
- **Home Manager** — user-level declarative dotfiles and packages
- **Chinese mirrors** — USTC, TUNA, SJTU mirrors for faster Nix downloads
- **Desktop environment** — Waybar, Rofi, Niri compositor, custom Fish prompt (Miyu)

## Quick Start

```bash
# Clone and rebuild
sudo nixos-rebuild switch --flake .#nixos
```

## Structure

```
├── flake.nix                 # Flake entry point
├── configuration.nix         # System-level configuration
├── hardware-configuration.nix # Auto-generated hardware config
├── chinese.nix               # Chinese locale & font config
└── home/
    ├── home.nix              # Home Manager config
    ├── miyu.fish             # Custom Fish prompt
    ├── niri/                 # Niri compositor config
    ├── rofi/                 # Rofi launcher config
    ├── waybar/               # Waybar status bar config
    └── result                # (symlink to built result)
```
