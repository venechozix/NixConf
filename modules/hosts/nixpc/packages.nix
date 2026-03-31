{ self, inptus, ... }:
{

  flake.nixosModules.nixpcPackages =
    { config, pkgs, ... }:
    {

      nixpkgs.config.permittedInsecurePackages = [
        "python3.13-youtube-dl-2021.12.17"
      ];
      environment.systemPackages = with pkgs; [
        #dev
        android-tools
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
        python3Packages.sounddevice
        vscodium
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
        firefox
        gimp
        castnow
        vlc
        openrgb-with-all-plugins
        gsettings-desktop-schemas
        geekbench
        scrcpy
        ntfs3g
        parsec-bin
      ];

    };

}
