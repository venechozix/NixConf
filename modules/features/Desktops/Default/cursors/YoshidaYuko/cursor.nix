{ self, ... }:
let
  name = "saber-alter-cursor";
  size = 32;
in
{
  flake.lib.cursor = { inherit name size; };

  perSystem =
    { pkgs, ... }:
    {
      packages.yoshida-cursor = pkgs.stdenvNoCC.mkDerivation {
        pname = "yoshida-yuko-cursor";
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

  flake.homeModules.yoshida-yuko-cursor =
    { pkgs, ... }:
    {
      home.pointerCursor = {
        enable = true;
        inherit name size;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.yoshida-cursor;
        x11.enable = true;
        gtk.enable = true;
        sway.enable = true;
      };
    };
}
