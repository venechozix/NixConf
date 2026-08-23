{ self, inputs, ... }:
{

  flake.nixosModules.nixserverHardware =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ehci_pci"
        "ata_piix"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/0e9d0be5-2ac8-4a65-aefc-276ec275ae97";
        fsType = "ext4";
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/1b3c930d-dd9b-40c5-9176-4661152f404e"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
