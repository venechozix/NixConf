{ self, inputs, ... }:
{

  flake.nixosModules.nixserverPackages =
    {
      config,
      pkgs,
      inputs,
      ...
    }:
    {

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          cat = "bat";
          ll = "ls -l";
          rebuild = "sudo nixos-rebuild switch --flake /home/chozix/rew#nixserver";
          fupdate = "nix flake update --flake /home/chozix/rew";
          remove = "sudo nix-collect-garbage -d && sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +2";
        };
        histSize = 1000;
        ohMyZsh = {
          # "ohMyZsh" without Home Manager
          enable = true;
          plugins = [ "git" ];
          theme = "nicoulaj";
        };
      };
      environment.systemPackages = with pkgs; [

        #dev
        libgccjit
        vim
        wget
        bat
        tealdeer
        lua
        binutils
        gnumake
        glibc
        python313
        python314
        pyenv

        #utils
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

        zip
        unzip
        rar
        unrar
        p7zip

      ];

    };

}
