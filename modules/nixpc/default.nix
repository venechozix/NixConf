{ self, inputs, ... }:
{

  flake.nixosConfigurations.nixpc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.nixpcConfig
    ];
  };

}
