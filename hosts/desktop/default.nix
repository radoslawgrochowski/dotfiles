{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  networking.hostName = "radoslawgrochowski-desktop";
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;

  swapDevices = [{ device = "/swapfile"; size = 8192; }];

  fileSystems."/media/secondary" = {
    device = "/dev/nvme0n1p3";
  };
}

