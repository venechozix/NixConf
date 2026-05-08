{ self, inputs, ... }:
{

  flake.nixosModules.saucepcHardware =
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
        "vmd"
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "sd_mod"
      ];
      boot.initrd.kernelmodules = [ "amdgpu" ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/9aa8003a-80a0-44de-b93d-702a3497cae3";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/2977-C705";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      fileSystems."/mnt/hdd1" = {
        device = "/dev/disk/by-uuid/0C9825169824FFB6"; # replace with your UUID
        fsType = "ntfs3"; # or whatever lsblk shows
        options = [
          "defaults"
          "nofail"
        ]; # nofail = don’t break boot if missing
      };
      swapDevices = [
        { device = "/dev/disk/by-uuid/e2f87c63-4534-47e8-aaf8-332de9b81554"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

}
