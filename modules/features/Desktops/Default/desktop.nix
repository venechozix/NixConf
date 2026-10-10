{ self, inputs, ... }:
{

  flake.nixosModules.desktop =
    { pkgs, inputs, ... }:
    {
      imports = [
        self.nixosModules.niri
        self.nixosModules.fonts
        self.nixosModules.xdg-mime
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

      services.gvfs.enable = true;

      # Configure Qt Theming
      qt = {
        enable = true;
        platformTheme = "qt5ct";
        style = "adwaita-dark"; # Or "breeze" / "fusion" depending on preference
      };

      programs.thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin # clic derecho → extraer/comprimir
          thunar-volman # automontaje de medios
        ];
      };

      programs.xfconf.enable = true; # sin esto Thunar no guarda sus preferencias
      services.tumbler.enable = true; # miniaturas

      environment.systemPackages = with pkgs; [
        noctalia
        polkit_gnome
        ncdu
        htop
        eog
        icu77
        gsettings-desktop-schemas
        glib
        glib-networking
        gammastep

        file-roller
        ffmpegthumbnailer

        libsForQt5.qt5ct
        kdePackages.qt6ct
        kdePackages.breeze
      ];

    };

}
