{ self, inptus, ... }:
{

  flake.nixosModules.nixpcPackages =
    { config, pkgs, ... }:
    {

      environment.systemPackages = with pkgs; [
        #dev
        android-tools
        libgccjit
        vim
        wget
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
        vscodium
        #utils
        file
        ncdu
        icu77
        ntfs3g
        gsettings-desktop-schemas

        htop
        pavucontrol
        fastfetch
        spotify
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
        gimp
        vlc
        openrgb-with-all-plugins
        parsec-bin
      ];

    };

}
