{ self, inputs, ... }:
{

  flake.nixosModules.virt =
    { config, pkgs, ... }:
    {
      virtualisation.virtualbox.host.enable = true;

      virtualisation.docker = {
        enable = true;
      };
    };

}
