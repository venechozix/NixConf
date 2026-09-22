{ self, inputs, ... }:
{

  flake.nixosConfigurations.nixserver = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      self.nixosModules.nixserverConfig
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.chozix = self.homeModules.admin;
          users.jesusg = self.homeModules.jesusg;
          backupFileExtension = "backup";
          extraSpecialArgs = { inherit inputs; };
        };
      }
    ];
  };

}
