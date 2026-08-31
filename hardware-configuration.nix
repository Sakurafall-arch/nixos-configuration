{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "vmd" "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];


  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=4G" "mode=755" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9249-EEC5";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };


  fileSystems."/etc" =
    { device = "/dev/disk/by-uuid/2b0dc6a2-715e-48c7-b161-0a2fd7b26d20";
      fsType = "btrfs";
      options = [ "subvol=@etc" "compress-force=zstd" ];
    };

  fileSystems."/var" =
    { device = "/dev/disk/by-uuid/2b0dc6a2-715e-48c7-b161-0a2fd7b26d20";
      fsType = "btrfs";
      options = [ "subvol=@var" "compress-force=zstd" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/2b0dc6a2-715e-48c7-b161-0a2fd7b26d20";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/2b0dc6a2-715e-48c7-b161-0a2fd7b26d20";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress-force=zstd" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/d3ed81a1-20a1-48e0-989f-93d79e129d06"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
