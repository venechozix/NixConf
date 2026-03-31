{ self, inputs }:
{

  flake.nixosModules.gaming =
    {
      config,
      pkgs,
      inputs,
      ...
    }:
    #let
    #  aagl = inputs.aagl;
    #in
    {

      #  imports = [ aagl.nixosModules.default ];
      #  nix.settings = aagl.nixConfig;
      #  programs.honkers-railway-launcher.enable = true;

      #Steam
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
        protontricks.enable = true;
      };

      programs.appimage.enable = true;
      programs.appimage.binfmt = true;

      hardware.opentabletdriver = {
        enable = true;
        daemon.enable = true;
      };

      environment.systemPackages = with pkgs; [
        #gaming
        gamescope
        cemu
        ryubing
        protonup-qt
        opentabletdriver
        osu-lazer-bin
        lutris
        heroic-unwrapped
        glib
        glib-networking
        prismlauncher-unwrapped
        dconf
        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
        vkbasalt
        mangohud
        goverlay
      ];

    };

}
