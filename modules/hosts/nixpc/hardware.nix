{ self, inputs, ... }:
{

  flake.nixosModules.nixpcHardware =
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
        "ahci"
        "usbhid"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ "amdgpu" ];
      boot.kernelModules = [
        "i2c-dev"
        "v4l2loopback"
      ];
      boot.extraModulePackages = [ ];

      hardware.enableRedistributableFirmware = true;

      boot.kernelParams = [
        "video=DP-1:1280x1024@75"
        "video=HMDI-A-1:1366x768@60"
      ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/0001eeff-3af7-4672-83ec-f8a888eaeb6d";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/1729-6855";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      fileSystems."/mnt/hdd1" = {
        device = "/dev/disk/by-uuid/aec0f795-e32d-479b-a2a1-fc6842b42f95"; # replace with your UUID
        fsType = "ext4"; # or whatever lsblk shows
        options = [
          "defaults"
          "nofail"
        ]; # nofail = don’t break boot if missing
      };

      fileSystems."/home/chozix/drives/hdd1" = {
        device = "/dev/disk/by-uuid/aec0f795-e32d-479b-a2a1-fc6842b42f95"; # replace with your UUID
        fsType = "ext4"; # or whatever lsblk shows
        options = [
          "defaults"
          "nofail"
        ]; # nofail = don’t break boot if missing
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/bbead3af-12b1-472b-9445-16647426849c"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

}
