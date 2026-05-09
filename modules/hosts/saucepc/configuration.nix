{ self, inputs, ... }:
{

  flake.nixosModules.saucepcConfig =
    { config, pkgs, ... }:

    {
      imports = [
        self.nixosModules.saucepcHardware
        self.nixosModules.saucepcPackages

        self.nixosModules.sauceDesktop
        self.nixosModules.gaming

      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      hardware.graphics.enable = true;
      services.xserver.enable = true;
      services.xserver.videoDrivers = [ "amdgpu" ];

      # Bootloader.
      boot.loader.limine.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      boot.kernelPackages = pkgs.linuxPackages_latest;

      networking.hostName = "saucepc";

      # Enable networking
      networking.networkmanager.enable = true;

      services.displayManager.sddm.enable = true;

      services.printing.enable = true;

      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      users.defaultUserShell = pkgs.zsh;
      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.sauce = {
        isNormalUser = true;
        description = "sauce";
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "input"
          "tty"
        ];
      };

      nixpkgs.config.allowUnfree = true;

      system.stateVersion = "25.11"; # Did you read the comment?

    };

}
