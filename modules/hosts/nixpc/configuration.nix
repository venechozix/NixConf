{ self, inputs, ... }:
{

  flake.nixosModules.nixpcConfig =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.nixpcHardware
        self.nixosModules.niri
        self.nixosModules.nixpcPackages
        self.nixosModules.fonts
        self.nixosModules.gaming
        self.nixosModules.misc
        self.nixosModules.virt
      ];

      boot.kernelPackages = pkgs.pkgs.linuxPackages_6_12;

      hardware.graphics.enable = true;
      services.xserver.enable = true;
      services.xserver.videoDrivers = [ "amdgpu" ];

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "nixpc"; # Define your hostname.
      networking.networkmanager.enable = true;

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Set your time zone.
      time.timeZone = "America/Montevideo";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "es_UY.UTF-8";
        LC_IDENTIFICATION = "es_UY.UTF-8";
        LC_MEASUREMENT = "es_UY.UTF-8";
        LC_MONETARY = "es_UY.UTF-8";
        LC_NAME = "es_UY.UTF-8";
        LC_NUMERIC = "es_UY.UTF-8";
        LC_PAPER = "es_UY.UTF-8";
        LC_TELEPHONE = "es_UY.UTF-8";
        LC_TIME = "es_UY.UTF-8";
      };

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          ll = "ls -l";
          remove = "sudo nix-collect-garbage -d && sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +2";
        };
        histSize = 1000;
        ohMyZsh = {
          # "ohMyZsh" without Home Manager
          enable = true;
          plugins = [ "git" ];
          theme = "nicoulaj";
        };
      };

      users.defaultUserShell = pkgs.zsh;

      services.syncthing = {
        enable = true;
        group = "syncthing";
        user = "chozix";
        dataDir = "/home/chozix/"; # Default folder for new synced folders
        configDir = "/home/chozix/.config/syncthing"; # Folder for Syncthing's settings and keys
      };

      services.udisks2.enable = true;

      services.avahi.enable = true;

      users.users.chozix = {
        isNormalUser = true;
        description = "Jesus";
        extraGroups = [
          "networkmanager"
          "wheel"
          "syncthing"
          "docker"
        ];

        packages = with pkgs; [
          exfatprogs
          gparted
          exfat
          obsidian
          desmume
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

      # Enable sound with pipewire.
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;

        wireplumber.extraConfig."10-disable-agc" = {
          "monitor.alsa.properties" = {
            "capture.auto_gain_control" = false;
          };
        };

        #extraConfig.pipewire."92-low-latency" = {
        #  "context.properties" = {
        #    "default.clock.rate" = 48000;
        #    "default.clock.quantum" = 32;
        #    "default.clock.min-quantum" = 32;
        #    "default.clock.max-quantum" = 32;
        #  };
        #};

      };

      nixpkgs.config.allowUnfree = true;

      system.stateVersion = "25.11"; # Did you read the comment?
    };

}
