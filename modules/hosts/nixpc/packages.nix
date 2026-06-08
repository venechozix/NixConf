{ self, inputs, ... }:
{

  flake.nixosModules.nixpcPackages =
    {
      config,
      pkgs,
      inputs,
      ...
    }:
    {

      programs.obs-studio = {
        enable = true;
        enableVirtualCamera = true;
        plugins = with pkgs.obs-studio-plugins; [
          droidcam-obs
        ];
      };

      nixpkgs.overlays = [ inputs.helium-flake.overlays.default ];

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
        woeusb
        file
        libGL
        pince
        ntfs3g
        exfatprogs
        gparted
        exfat
        f3

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

        reaper
        droidcam
        openvpn3
        openvpn

        helium
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
