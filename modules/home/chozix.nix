{ self, inputs, ... }:
{

  flake.homeModules.chozix =
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

      home.stateVersion = "26.05";

      imports = [
        self.homeModules.jeanne-D-Arc-Cursor
        self.homeModules.noctalia-settings
        self.homeModules.neovim
        self.homeModules.zed-editor
      ];

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

      xdg.configFile."xfce4/helpers.rc".text = ''
        TerminalEmulator=alacritty
      '';

      home.file.".config/kdeglobals".text = ''
        [General]
        TerminalApplication=alacritty
        TerminalService=alacritty.desktop
      '';

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


      home.packages = with pkgs; [
        super-productivity
      ];

    };

}
