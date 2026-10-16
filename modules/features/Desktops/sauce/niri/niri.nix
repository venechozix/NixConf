{ self, inputs, ... }:
{

  flake.nixosModules.sauceNiri =
    { pkgs, lib, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.niriSauce;
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.niriSauce = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
        settings = {

          spawn-at-startup = [
            (lib.getExe self'.packages.sauceNoctalia)
          ];

          prefer-no-csd = _: { };

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          input.mouse = {
            accel-speed = 0;
            accel-profile = "flat";
          };

          input.tablet = {
            off = _: { };
          };

          outputs = import ./_outputs.nix;

          layout = import ./_layout.nix;

          binds = import ./_binds.nix { inherit pkgs lib self'; };

          cursor = {
            xcursor-theme = "catppuccin-mocha-dark-cursors";
            xcursor-size = 24;
          };

          window-rules = [
            {
              geometry-corner-radius = 20;
              clip-to-geometry = true;
            }
          ];

        };
      };
    };
}
