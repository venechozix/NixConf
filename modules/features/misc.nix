{ self, inputs, ... }:
{

  flake.nixosModules.misc =
    { config, pkgs, ... }:
    {

      environment.systemPackages = with pkgs; [
        bluetui
      ];

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Experimental = true;
            FastConnectable = true;
          };
          Policy = {
            AutoEnable = true;
          };
        };
      };
    };
}
