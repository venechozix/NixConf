{ self, inputs, ... }:
{

  flake.nixosModules.misc =
    { config, pkgs, ... }:
    {

      environment.systemPackages = with pkgs; [
        bluetui
        mkchromecast
      ];

      services.avahi.enable = true;

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
