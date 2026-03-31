{ self, inputs, ... }:
{

  flake.nixosModules.virt =
    { config, pkgs, ... }:
    {

      programs.virt-manager.enable = true;

      users.groups.libvirtd.members = [ "chozix" ];

      virtualisation.libvirtd.enable = true;

      virtualisation.spiceUSBRedirection.enable = true;

      virtualisation.docker = {
        enable = true;
      };
    };

}
