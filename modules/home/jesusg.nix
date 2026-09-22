{ self, inputs, ... }:
{

  flake.homeModules.admin =
    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }:

    {
      home.username = "jesusg";
      home.homeDirectory = "/home/jesusg";
      home.stateVersion = "26.05";

      home.file.".config/nvim".source = ./nvim;

      # - START OF NVIM -
      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        withPython3 = true;
        withRuby = false;

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
          clang-tools # c

          #Formatters and linters
          stylua
          nixfmt
        ];

      };
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
          user.name = "Jg";
          user.email = "setituppls@gmail.com";
        };
      };

      # - END OF GIT -

    };

}
