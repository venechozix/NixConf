{ config, pkgs, ... }:
{
  flake.nixosModules.xdg-mime =
    { config, pkgs, ... }:
    {

      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
        ];
        config.common.default = [ "gtk" ];

      };

      xdg.menus.enable = true;

      # Register the default terminal schema target explicitly
      xdg.terminal-exec = {
        enable = true;
        settings = {
          default = [ "alacritty.desktop" ];
        };
      };

      environment.sessionVariables.BROWSER = "zen-twilight";

      xdg.mime = {
        enable = true;
        defaultApplications = {
          "inode/directory" = [ "thunar.desktop" ];
          "x-scheme-handler/file" = [ "thunar.desktop" ];
          # Navegador
          "text/html" = [ "zen-twilight.desktop" ];
          "x-scheme-handler/http" = [ "zen-twilight.desktop" ];
          "x-scheme-handler/https" = [ "zen-twilight.desktop" ];
          "x-scheme-handler/about" = [ "zen-twilight.desktop" ];
          "x-scheme-handler/unknown" = [ "zen-twilight.desktop" ];
          "application/xhtml+xml" = [ "zen-twilight.desktop" ];
        };
      };

      environment.etc."xdg/menus/applications.menu".source =
        "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

      environment.systemPackages = with pkgs; [
        xdg-terminal-exec
      ];
    };
}
