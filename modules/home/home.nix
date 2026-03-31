{ self, inputs, ... }:
{

  flake.homeModules.chozixHome =
    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }:

    {
      home.username = "chozix";
      home.homeDirectory = "/home/chozix";
      home.stateVersion = "25.11";

      programs.alacritty = {
        enable = true;
        settings = {
          window = {
            decorations = "None";
            padding = {
              x = 5;
              y = 5;
            };
          };
        };
      };

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

      home.file.".config/nvim".source = ./nvim;

      # - END OF NVIM -

      # - START OF TMUX -

      programs.tmux = {
        enable = true;
        mouse = true;
        baseIndex = 1;
        shortcut = "Space";
        terminal = "tmux-256color";

        extraConfig = ''

          set -g @catppuccin_flavour "mocha"

          bind -n M-H previous-window
          bind -n M-L next-window
        '';
        plugins = with pkgs.tmuxPlugins; [
          sensible
          yank
          vim-tmux-navigator
          catppuccin

        ];
      };

      # - END OF TMUX -

      # - START OF GIT -
      programs.git = {
        enable = true;
        settings = {
          core.askPass = "";
          credential.helper = "store";
          init.defaultBranch = "main";
          user.name = "chozix";
          user.email = "venechozix@gmail.com";
        };
      };

      # - END OF GIT -

      home.pointerCursor = {
        enable = true;
        name = "catppuccin-mocha-dark-cursors";
        package = pkgs.catppuccin-cursors.mochaDark;
        x11.enable = true;
        gtk.enable = true;
        sway.enable = true;
        size = 24;
      };

      gtk = {
        enable = true;

        theme = {
          name = "Adwaita-dark";
          package = pkgs.gnome-themes-extra;
        };

        iconTheme = {
          name = "Adwaita";
          package = pkgs.adwaita-icon-theme;
        };

        gtk3.extraConfig = {
          gtk-application-prefer-dark-theme = true;
        };
      };

      # dconf.settings = {
      #   "org/gnome/desktop/interface" = {
      #     color-scheme = "prefer-dark";
      #   };
      # };

      home.packages = with pkgs; [
        inputs.zen-browser.packages."${stdenv.hostPlatform.system}".twilight
        chatterino7
        brave
        qbittorrent
        koodo-reader
      ];
    };

}
