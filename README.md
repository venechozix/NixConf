# ❄️My NixOS Configuration

My personal NixOS configuration, managed with Flake parts across multiple machines.

![](https://i.imgur.com/ExFk10S.png)

## Structure

```
.
├── flake.lock
├── flake.nix
├── LICENSE
├── modules
│   ├── features
│   │   ├── Desktops
│   │   │   ├── Default
│   │   │   │   ├── desktop.nix
│   │   │   │   ├── fonts.nix
│   │   │   │   ├── gtk.nix
│   │   │   │   ├── niri.nix
│   │   │   │   ├── noctalia.json
│   │   │   │   └── noctalia.nix
│   │   │   └── sauce
│   │   │       ├── desktop.nix
│   │   │       ├── niri.nix
│   │   │       ├── noctalia.json
│   │   │       └── noctalia.nix
│   │   ├── gaming.nix
│   │   ├── kde-connect.nix
│   │   ├── misc.nix
│   │   ├── syncthing.nix
│   │   └── virt.nix
│   ├── home
│   │   ├── chozix.nix
│   │   ├── nvim
│   │   │   └── nvim lua files...
│   │   ├── options.nix
│   │   └── sauce.nix
│   ├── hosts
│   │   ├── nixpc
│   │   │   ├── configuration.nix
│   │   │   ├── default.nix
│   │   │   ├── hardware.nix
│   │   │   └── packages.nix
│   │   └── saucepc
│   │       ├── configuration.nix
│   │       ├── default.nix
│   │       ├── hardware-configuration.nix
│   │       └── packages.nix
│   └── parts.nix
└── README.md
```

## Hosts

| Hostname | Description |
|----------|-------------|
| `nixpc`  | Desktop  |
| `sauce`  | Friend's Desktop  |

## Applying Configuration

Rebuild a specific host:

```bash
sudo nixos-rebuild switch --flake .#hostname
```

