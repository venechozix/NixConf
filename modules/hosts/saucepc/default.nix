{ self, inputs, ... }:
{

  flake.nixosConfigurations.saucepc = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      self.nixosModules.saucepcConfig
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.sauce = self.homeModules.sauce;
          backupFileExtension = "backup";
          extraSpecialArgs = { inherit inputs; };
        };
      }
    ];
  };

}
