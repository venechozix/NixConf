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

      nixpkgs.config.permittedInsecurePackages = [
        "electron-41.10.6"
      ];

      services.xserver.excludePackages = [ pkgs.xterm ];

      environment.systemPackages = with pkgs; [

        #dev
        zed-editor-fhs
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
        sane-backends
        #utils
        smartmontools
        e2fsprogs
        sshfs
        woeusb
        file
        libGL
        pince
        ntfs3g
        exfatprogs
        gparted
        exfat
        f3
        cmatrix

        fastfetch
        spotify
        keepassxc

        thunar

        teamspeak6-client
        zip
        unzip
        rar
        unrar
        p7zip
        pavucontrol

        droidcam
        openvpn3
        openvpn
        audacity
        helium
        kdePackages.dolphin
        wine
        wine64
        winetricks
        gimp
        vlc
        openrgb-with-all-plugins
        moonlight-qt
        parsec-bin
        pear-desktop

        equibop

        inputs.limusic.packages."${stdenv.hostPlatform.system}".default

        inputs.nix-gaming.packages."${stdenv.hostPlatform.system}".osu-lazer-bin
        inputs.nix-gaming.packages."${stdenv.hostPlatform.system}".osu-stable

        inputs.zen-browser.packages."${stdenv.hostPlatform.system}".twilight
        qbittorrent
        koodo-reader
        obsidian

      ];

    };

}
