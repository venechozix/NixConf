{ self, inptus, ... }:
{

  flake.nixosModules.nixpcPackages =
    { config, pkgs, ... }:
    {

      programs.obs-studio = {
        enable = true;
        enableVirtualCamera = true;
        plugins = with pkgs.obs-studio-plugins; [
          droidcam-obs
        ];
      };

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
        libGL
        pince
        ntfs3g
        exfatprogs
        gparted
        exfat

        fastfetch
        spotify
        vesktop
        keepassxc

        zip
        unzip
        rar
        unrar
        p7zip
        pavucontrol

        droidcam
        openvpn3

        kdePackages.dolphin
        wine
        wine64
        winetricks
        gimp
        vlc
        openrgb-with-all-plugins
        parsec-bin
      ];

    };

}
