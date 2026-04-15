{ self, inputs, ... }:
{

  flake.nixosModules.misc =
    { config, pkgs, ... }:
    {

      environment.systemPackages = with pkgs; [
        bluetui
        mkchromecast
        ffmpeg
        chromium
      ];

      services.avahi.enable = true;

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [
          8008
          8009
          8010
          8443
        ];
        allowedUDPPorts = [
          5353
          32768
          60999
        ];
        # Or more broadly allow the range mkchromecast uses:
        allowedTCPPortRanges = [
          {
            from = 5000;
            to = 5100;
          } # mkchromecast default streaming port
        ];
      };

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
