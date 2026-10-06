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

      xdg.mime = {
        enable = true;
        defaultApplications = {
          "inode/directory" = [ "org.kde.dolphin.desktop" ];
          "x-scheme-handler/file" = [ "org.kde.dolphin.desktop" ];
        };
      };

      # Hardlink the plasma application menu where Dolphin expects it
      environment.etc."xdg/menus/applications.menu".source =
        "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

      environment.systemPackages = with pkgs; [
        xdg-terminal-exec
        kdePackages.plasma-workspace # Provides the underlying menu structure Dolphin requires
      ];
    };
}
