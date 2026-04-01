{ self, ... }:
{

  flake.nixosModules.desktop =
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

      services.udisks2.enable = true;

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          cat = "bat";
          ll = "ls -l";
          rebuild = "sudo nixos-rebuild switch --flake /home/chozix/rew#nixpc";
          fupdate = "nix flake update --flake /home/chozix/rew";
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
