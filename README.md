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
    │       ├── init.lua
    │       └── lua
    │           ├── config
    │           │   └── keymaps.lua
    │           └── plugins
    │               ├── cmp.lua
    │               ├── format.lua
    │               ├── lsp.lua
    │               ├── telescope.lua
    │               └── treesitter.lua
    ├── hosts
    │   └── nixpc
    │       ├── configuration.nix
    │       ├── default.nix
    │       ├── hardware.nix
    │       └── packages.nix
    └── parts.nix```

> Adjust the tree above to match your actual layout.

## Hosts

| Hostname | Description |
|----------|-------------|
| `host1`  | Desktop / main workstation |
| `host2`  | Laptop / portable setup |

## Applying Configuration

Rebuild a specific host:

```bash
sudo nixos-rebuild switch --flake .#hostname
```

Update flake inputs:

```bash
nix flake update
```
