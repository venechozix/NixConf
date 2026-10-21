{ self, ... }:
let
  name = "scm-saber-alter-3rd-ascensio-596775dd";
  size = 32;
in
{
  flake.lib.cursor = { inherit name size; };

  perSystem =
    { pkgs, ... }:
    {
      packages.saber-cursor = pkgs.stdenvNoCC.mkDerivation {
        pname = "saber-alter-cursor";
        version = "1.0";
        src = ./scm-saber-alter-3rd-ascensio-596775dd;

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

  flake.homeModules.saber-alter-cursor =
    { pkgs, ... }:
    {
      home.pointerCursor = {
        enable = true;
        inherit name size;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.saber-cursor;
        x11.enable = true;
        gtk.enable = true;
        sway.enable = true;
      };
    };
}
