{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  networking.hostName = "radoslawgrochowski-desktop";
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}

