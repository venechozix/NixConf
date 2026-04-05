{ self, inputs, ... }:
{

  flake.nixosModules.nixpcConfig =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.nixpcHardware
        self.nixosModules.nixpcPackages

        self.nixosModules.desktop
        self.nixosModules.gaming
        self.nixosModules.misc
        self.nixosModules.virt
        self.nixosModules.syncthing
      ];

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

      services.hardware.openrgb.enable = true;

      users.defaultUserShell = pkgs.zsh;

      services.avahi.enable = true;

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

        wireplumber.extraConfig."10-disable-agc" = {
          "monitor.alsa.properties" = {
            "capture.auto_gain_control" = false;
          };
        };
      };

      nixpkgs.config.allowUnfree = true;

      system.stateVersion = "25.11"; # Did you read the comment?
    };

}
