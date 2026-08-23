{ self, inputs, ... }:
{

  flake.nixosModules.nixserverConfig =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.nixserverHardware
      ];

      # Bootloader.
      # boot.loader.systemd-boot.enable = true;
      boot.loader.limine.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "nixserver";
      networking.networkmanager.enable = true;

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      users.defaultUserShell = pkgs.zsh;

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

      nixpkgs.config.allowUnfree = true;

      system.stateVersion = "26.05"; # Did you read the comment?
    };

}
