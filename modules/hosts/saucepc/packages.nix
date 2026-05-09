{ self, inputs, ... }:
{

  flake.nixosModules.saucepcPackages =
    { config, pkgs, ... }:
    {

      environment.systemPackages = with pkgs; [
        #dev
        libgccjit
        vim
        wget
        alacritty
        xclip
        bat
        tealdeer
        lua
        binutils
        gnumake
        glibc
        python313
        python314
        pyenv
        #utils
        file
        win2xcur
        ncdu
        htop
        kdePackages.kdenlive
        readest
        icu77
        pavucontrol
        fastfetch
        vesktop
        keepassxc
        zip
        unzip
        rar
        unrar
        p7zip
        kdePackages.dolphin
        wine
        winetricks
        wine64Packages.waylandFull
        obs-studio
        firefox
        gimp
        castnow
        vlc
        openrgb-with-all-plugins
        gsettings-desktop-schemas
        libreoffice
        redshift
        unar
        playerctl
        gamemode
        discord
      ];
    };

}
