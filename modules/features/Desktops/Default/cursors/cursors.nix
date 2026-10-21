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

    cursor = mkOption {
      type = types.submodule {
        options = {
          theme = mkOption { type = types.str; default = "saber-alter-1"; };
          size = mkOption { type = types.int; default = 32; };
        };
      };
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

    flake.homeModules.cursor =
      { pkgs, ... }:
      {
        home.pointerCursor = {
          enable = true;
          name = cfg.cursors.${cfg.cursor.theme}.name;
          size = cfg.cursor.size;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}."cursor-${cfg.cursor.theme}";
          x11.enable = true;
          gtk.enable = true;
          sway.enable = true;
        };
      };
  };
}
