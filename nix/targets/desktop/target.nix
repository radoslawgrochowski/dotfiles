{ config, lib, pkgs, modulesPath, ... }:

{
  networking.hostName = "radoslawgrochowski-desktop";
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
}

