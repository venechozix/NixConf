{ self, ... }:
{

  flake.nixosModules.sauceDesktop =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.niri
        self.nixosModules.fonts
        self.nixosModules.gtk
      ];

      security.polkit.enable = true;

      services.flatpak.enable = true;

      programs.appimage.enable = true;
      programs.appimage.binfmt = true;

      # Set your time zone.

      time.timeZone = "America/Santiago";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "es_CL.UTF-8";
        LC_IDENTIFICATION = "es_CL.UTF-8";
        LC_MEASUREMENT = "es_CL.UTF-8";
        LC_MONETARY = "es_CL.UTF-8";
        LC_NAME = "es_CL.UTF-8";
        LC_NUMERIC = "es_CL.UTF-8";
        LC_PAPER = "es_CL.UTF-8";
        LC_TELEPHONE = "es_CL.UTF-8";
        LC_TIME = "es_CL.UTF-8";
      };
      services.udisks2.enable = true;

      services.xserver.xkb = {
        layout = "latam";
        variant = "";
      };

      # Configure console keymap
      console.keyMap = "la-latin1";
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          cat = "bat";
          ll = "ls -l";
          rebuild = "sudo nixos-rebuild switch --flake /home/sauce/rew#nixpc";
          fupdate = "nix flake update --flake /home/sauce/rew";
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

      environment.systemPackages = with pkgs; [
        polkit_gnome
        ncdu
        htop
        eog
        nautilus
        icu77
        gsettings-desktop-schemas
        glib
        glib-networking
      ];

    };

}
