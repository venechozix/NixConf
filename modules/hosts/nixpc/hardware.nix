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
        device = "/dev/disk/by-uuid/a8fe5aa5-ca1b-4571-9c09-4e9c5c164255";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/C6EC-6EFF";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      fileSystems."/mnt/hdd1" = {
        device = "/dev/disk/by-uuid/77808b26-1409-4691-aee6-9f506fe02e9c"; # replace with your UUID
        fsType = "ext4"; # or whatever lsblk shows
        options = [
          "defaults"
          "nofail"
        ]; # nofail = don’t break boot if missing
      };

      fileSystems."/home/chozix/drives/hdd1" = {
        device = "/dev/disk/by-uuid/77808b26-1409-4691-aee6-9f506fe02e9c"; # replace with your UUID
        fsType = "ext4"; # or whatever lsblk shows
        options = [
          "defaults"
          "nofail"
        ]; # nofail = don’t break boot if missing
      };

      fileSystems."/home/chozix/drives/hdd2" = {
        device = "/dev/disk/by-uuid/628f7e98-4d7f-4c74-a2b2-1c1bf1dafae6"; # replace with your UUID
        fsType = "ext4"; # or whatever lsblk shows
        options = [
          "defaults"
          "nofail"
        ]; # nofail = don’t break boot if missing
      };

      fileSystems."/mnt/hdd2" = {
        device = "/dev/disk/by-uuid/628f7e98-4d7f-4c74-a2b2-1c1bf1dafae6"; # replace with your UUID
        fsType = "ext4"; # or whatever lsblk shows
        options = [
          "defaults"
          "nofail"
        ]; # nofail = don’t break boot if missing
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/608ee85a-0cea-4dfd-88eb-8f7a8476dc84"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

}
