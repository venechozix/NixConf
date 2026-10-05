{ config, pkgs, ... }:
{
  flake.nixosModules.xdg-mime =
    { config, pkgs, ... }:
    {

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
        config.common.default = [ "gnome" ];

      };
      xdg.mime.enable = true;

      xdg.mime.defaultApplications = {
        "inode/directory" = "org.kde.dolphin.desktop";
      };
    };
}
