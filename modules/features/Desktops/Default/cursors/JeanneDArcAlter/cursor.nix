{ self, ... }:
let
  name = "jeanne-D-Arc-Cursor";
  size = 32;
in
{
  flake.lib.cursor = { inherit name size; };

  perSystem =
    { pkgs, ... }:
    {
      packages.jeanneAlter-cursor = pkgs.stdenvNoCC.mkDerivation {
        pname = "jeanne-D-Arc-Cursor";
        version = "1.0";
        src = ./cursor;

        dontConfigure = true;
        dontBuild = true;
        dontFixup = true;

        installPhase = ''
          runHook preInstall
          mkdir -p $out/share/icons/${name}
          cp -r . $out/share/icons/${name}/
          runHook postInstall
        '';
      };
    };

  flake.homeModules.jeanne-D-Arc-Cursor =
    { pkgs, ... }:
    {
      home.pointerCursor = {
        enable = true;
        inherit name size;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.jeanneAlter-cursor;
        x11.enable = true;
        gtk.enable = true;
        sway.enable = true;
      };
    };
}
