# ❄️My NixOS Configuration

My personal NixOS configuration, managed with Nix Flakes across multiple machines.

![](https://i.imgur.com/ExFk10S.png)

## Structure

```
.
├── flake.lock
├── flake.nix
├── LICENSE
└── modules
    ├── features
    │   ├── desktop # Packages needed by the desktop.nix file
    │   │   ├── fonts.nix
    │   │   ├── gtk.nix
    │   │   ├── niri.nix
    │   │   ├── noctalia.json
    │   │   └── noctalia.nix
    │   ├── desktop.nix
    │   ├── gaming.nix
    │   ├── misc.nix
    │   ├── syncthing.nix
    │   └── virt.nix
    ├── home
    │   ├── home.nix
    │   └── nvim
    │       └── nvim configs...
    ├── hosts
    │   └── nixpc
    │       ├── configuration.nix
    │       ├── default.nix
    │       ├── hardware.nix
    │       └── packages.nix
    └── parts.nix
```

## Hosts

| Hostname | Description |
|----------|-------------|
| `nixpc`  | Desktop  |

## Applying Configuration

Rebuild a specific host:

```bash
sudo nixos-rebuild switch --flake .#hostname
```

