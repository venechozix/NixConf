{ self, inputs, ... }: {
  flake.homeModules.zed-editor =
    { pkgs, ... }:
    {
      programs.zed-editor = {
        enable = true;

        # Zed extensions (Nix syntax support + nil/nixd integration)
        extensions = [ "nix" ];

        # Wrapped onto Zed's PATH, so no system-wide install needed
        extraPackages = with pkgs; [
          nixd
          nil
          nixfmt # called nixfmt-rfc-style on older nixpkgs
          basedpyright
          ruff
        ];

        userSettings = {
          languages = {
            Nix = {
              language_servers = [
                "nixd"
                "!nil"
              ];
              formatter.external.command = "nixfmt";
            };
            Python = {
              language_servers = [
                "basedpyright"
                "ruff"
                "!pyright"
                "!pylsp"
              ];
              format_on_save = "on";
              formatter.language_server.name = "ruff";
            };
          };

          lsp = {
            nixd.settings = {
              formatting.command = [ "nixfmt" ];
            };
            basedpyright.settings.basedpyright.analysis = {
              typeCheckingMode = "standard";
            };
          };
        };
      };
    };
}
