{ self, inputs, ... }:
{

  flake.nixosModules.niri =
    { pkgs, lib, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.defNiri;
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
      packages.defNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
        settings = {

          spawn-at-startup = [
            (lib.getExe self'.packages.defNoctalia)
            (lib.getExe pkgs.equibop)
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

          animations = import ./_animations.nix;

          outputs = import ./_outputs.nix;

          layout = import ./_layout.nix;

          binds = import ./_binds.nix { inherit pkgs lib self'; };

          cursor = {
            xcursor-theme = "catppuccin-mocha-dark-cursors";
            xcursor-size = 24;
          };

        }
        // import ./_rules.nix;
      };
    };
}
