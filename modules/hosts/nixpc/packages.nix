{ self, inptus, ... }:
{

  flake.nixosModules.nixpcPackages =
    { config, pkgs, ... }:
    {

      # - START OF NVIM -
      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        plugins = with pkgs.vimPlugins; [
          telescope-nvim
          plenary-nvim
          catppuccin-vim
          nvim-treesitter-textobjects

          vim-tmux-navigator

          nvim-lspconfig
          cmp-nvim-lsp
          nvim-cmp
          cmp-buffer
          cmp-path
          cmp-cmdline
          cmp-nvim-lsp-signature-help

          (nvim-treesitter.withPlugins (p: [
            p.bash
            p.c
            p.lua
            p.python
            p.javascript
            p.typescript
            p.json
            p.html
            p.css
            p.markdown
            p.markdown_inline
            p.nix
            p.go
            p.rust
          ]))
        ];

        extraPackages = with pkgs; [
          fd
          ripgrep

          #Language Servers
          lua-language-server
          nil # Nix

          #Formatters and linters
          stylua
          nixfmt-rfc-style
        ];

      };
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
