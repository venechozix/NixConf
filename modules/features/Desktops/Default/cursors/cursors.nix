{
  config,
  lib,
  self,
  ...
}:
let
  cfg = config.flake;
  inherit (lib) mkOption types;

  # nombre que pide el compositor -> cursor equivalente que suele existir
  fallbacks = {
    "e-resize" = "ew-resize";
    "w-resize" = "ew-resize";
    "n-resize" = "ns-resize";
    "s-resize" = "ns-resize";
    "ne-resize" = "nesw-resize";
    "sw-resize" = "nesw-resize";
    "nw-resize" = "nwse-resize";
    "se-resize" = "nwse-resize";
    "col-resize" = "ew-resize";
    "row-resize" = "ns-resize";
    "grab" = "fleur";
    "grabbing" = "fleur";
  };

  linkFallbacks = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (alias: target: ''
      if [ ! -e "$dest/cursors/${alias}" ] && [ -e "$dest/cursors/${target}" ]; then
        ln -s ${target} "$dest/cursors/${alias}"
      fi
    '') fallbacks
  );

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
                dest=$out/share/icons/${c.name}
                mkdir -p $dest
                cp -r . $dest/
                ${linkFallbacks}
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
