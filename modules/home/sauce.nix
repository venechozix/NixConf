{ self, inputs, ... }:
{

  flake.homeModules.sauce =
    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }:

    {

      imports = [
        self.homeModules.neovim
      ];

      home.username = "sauce";
      home.homeDirectory = "/home/sauce";
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

      # - START OF GIT -
      programs.git = {
        enable = true;
        settings = {
          core.askPass = "";
          credential.helper = "store";
          init.defaultBranch = "main";
          user.name = "sauce";
          user.email = "agustinmazzinni@gmail.com";
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

      home.packages = with pkgs; [
        inputs.zen-browser.packages."${stdenv.hostPlatform.system}".twilight
        qbittorrent
        koodo-reader
        gparted
      ];
    };

}
