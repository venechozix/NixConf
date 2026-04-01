{ self, inputs, ... }:
{

  flake.nixosModules.gaming =
    {
      config,
      pkgs,
      inputs,
      ...
    }:
    let
      aagl = inputs.aagl;
    in
    {

      imports = [ aagl.nixosModules.default ];
      nix.settings = aagl.nixConfig;
      programs.honkers-railway-launcher.enable = true;
      programs.sleepy-launcher.enable = true;

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

      hardware.opentabletdriver = {
        enable = true;
        daemon.enable = true;
      };

      environment.systemPackages = with pkgs; [
        #gaming
        gamescope
        desmume
        cemu
        ryubing
        protonup-qt
        opentabletdriver
        osu-lazer-bin
        lutris
        heroic-unwrapped
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
