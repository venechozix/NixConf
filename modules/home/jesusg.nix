{ self, inputs, ... }:
{

  flake.homeModules.jesusg =
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

      imports = [
              self.homeModules.neovim
      ];

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
