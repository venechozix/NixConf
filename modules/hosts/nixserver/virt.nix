{ self, inputs, ... }:
{

  flake.nixosModules.nixserverVirt =
    {
      config,
      pkgs,
      inputs,
      ...
    }:
    {

      #Temporal Module while i fine tune the original virt module or make a server virt one

      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
        };
        allowedBridges = [
          "br0"
          "virbr0"
        ];
      };

    };
}
