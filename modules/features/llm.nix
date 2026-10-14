{ self, ... }:
{
  flake.nixosModules.llms =
  { config, pkgs, ... }:
  {
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      lmstudio
      autopsy
    ];
  };
}
