{ self, inputs, ... }:
{

  flake.nixosModules.nixserverConfig =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.nixserverHardware

        self.nixosModules.nixserverPackages
        self.nixosModules.nixserverVirt
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Bootloader.
      boot.loader.grub.enable = true;
      boot.loader.grub.device = "/dev/sda";
      boot.loader.grub.useOSProber = true;

      # Use latest kernel.
      boot.kernelPackages = pkgs.linuxPackages_latest;

      networking.hostName = "NixServer";

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

      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      users.defaultUserShell = pkgs.zsh;

      programs.nix-ld.enable = true;

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
          "libvirtd"
          "kvm"
        ];
      };

      users.users.jesusg = {
        isNormalUser = true;
        description = "Pa";
        extraGroups = [
          "networkmanager"
          "wheel"
          "syncthing"
          "docker"
          "input"
          "tty"
          "libvirtd"
          "kvm"
        ];
      };

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      services.openssh.enable = true;

      networking = {
        useDHCP = false;

        networkmanager.enable = false;

        bridges.br0.interfaces = [ "eno1" ];

        interfaces = {
          eno1.useDHCP = false;

          br0 = {
            useDHCP = false;
            ipv4.addresses = [
              {
                address = "192.168.1.55";
                prefixLength = 24;
              }
            ];
          };
        };

        defaultGateway = "192.168.1.1";
        nameservers = [
          "1.1.1.1"
          "8.8.8.8"
        ];
      };

      system.stateVersion = "26.05"; # Did you read the comment?

    };
}
