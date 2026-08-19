{ self, ... }:
{

  flake.nixosModules.connect =
    { ... }:
    {
      programs.kdeconnect.enable = true;

      networking.firewall = rec {
        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
        allowedUDPPortRanges = allowedTCPPortRanges;
      };

    };
}
