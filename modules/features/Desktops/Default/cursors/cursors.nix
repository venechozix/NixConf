{ config, lib, self, ... }:
let
  cfg = config.flake;
  inherit (lib) mkOption types;
in
{
  options.flake = {
    cursors = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            name = mkOption { type = types.str; };
            src = mkOption { type = types.path; };
          };
        }
      );
      default = { };
    };


  };

  config = {
    perSystem =
      { pkgs, ... }:
      {
        packages = lib.mapAttrs' (
          key: c:
          lib.nameValuePair "cursor-${key}" (
            pkgs.stdenvNoCC.mkDerivation {
              pname = "cursor-${key}";
              version = "1.0";
              inherit (c) src;
              dontConfigure = true;
              dontBuild = true;
              dontFixup = true;
              installPhase = ''
                runHook preInstall
                mkdir -p $out/share/icons/${c.name}
                cp -r . $out/share/icons/${c.name}/
                runHook postInstall
              '';
            }
          )
        ) cfg.cursors;
      };

      flake.nixosModules.cursor =
        { lib, ... }:
        {
          options.custom.cursor = {
            theme = lib.mkOption {
              type = lib.types.enum (lib.attrNames cfg.cursors);
              default = "saber-alter-1";
            };
            size = lib.mkOption {
              type = lib.types.int;
              default = 32;
            };
          };
        };

      flake.homeModules.cursor =
        { osConfig, pkgs, ... }:
        let
          sel = osConfig.custom.cursor;
        in
        {
          home.pointerCursor = {
            enable = true;
            name = cfg.cursors.${sel.theme}.name;
            size = sel.size;
            package = self.packages.${pkgs.stdenv.hostPlatform.system}."cursor-${sel.theme}";
            x11.enable = true;
            gtk.enable = true;
            sway.enable = true;
          };
        };
  };
}
