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

      imports = [
        self.homeModules.neovim
      ];

      home.username = "chozix";
      home.homeDirectory = "/home/chozix";
      home.stateVersion = "26.05";

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
    };

}
