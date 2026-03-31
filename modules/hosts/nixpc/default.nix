{ self, inputs, ... }:
{

  flake.nixosConfigurations.nixpc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.nixpcConfig
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.chozix = self.homeModules.chozixHome;
          backupFileExtension = "backup";
          extraSpecialArgs = { inherit inputs; };
        };
      }
    ];
  };

}
