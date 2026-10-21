{ self, inputs, ... }:
{

  flake.nixosModules.nixpcConfig =
    {
      config,
      pkgs,
      inputs,
      ...
    }:
    {
      imports = [
        self.nixosModules.nixpcHardware
        self.nixosModules.nixpcPackages

        self.nixosModules.connect
        self.nixosModules.desktop
        self.nixosModules.gaming
        self.nixosModules.misc
        self.nixosModules.virt
        self.nixosModules.syncthing

        inputs.nix-gaming.nixosModules.pipewireLowLatency
      ];

      nix.settings = {
        substituters = [ "https://nix-gaming.cachix.org" ];
        trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
      };
      boot.kernelPackages = pkgs.pkgs.linuxPackages_6_12;

      hardware.graphics.enable = true;
      services.xserver.enable = true;
      services.xserver.videoDrivers = [ "amdgpu" ];

      # Bootloader.
      # boot.loader.systemd-boot.enable = true;
      boot.loader.limine.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "nixpc";
      networking.networkmanager.enable = true;

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      custom.cursor.theme = "jeanne-cursor-1" ;
      custom.cursor.size = 42;

      services.hardware.openrgb.enable = true;

      users.defaultUserShell = pkgs.zsh;

      services.avahi.enable = true;

      services.printing = {
        enable = true;
        drivers = [ pkgs.samsung-unified-linux-driver ];
      };

      users.users.chozix = {
        isNormalUser = true;
        description = "Jesus";
        extraGroups = [
          "networkmanager"
          "wheel"
          "syncthing"
          "docker"
          "input"
          "tty"
        ];
      };

      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
            user = "greeter";
          };
        };
      };

      programs.nix-ld.enable = true;

      # Enable sound with pipewire.
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;

        lowLatency = {
          # enable this module
          enable = true;
          # defaults (no need to be set unless modified)
          quantum = 64;
          rate = 48000;
        };

        wireplumber.extraConfig."10-disable-agc" = {
          "monitor.alsa.properties" = {
            "capture.auto_gain_control" = false;
          };
        };
      };

      nixpkgs.config.allowUnfree = true;

      system.stateVersion = "26.05"; # Did you read the comment?
    };

}
