{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      horizontalScrolling = true;
      naturalScrolling = true;
    };
  };

  networking.hostName = "radoslawgrochowski-dell";

  hardware.bluetooth.enable = true;
  hardware.pulseaudio.extraConfig = "
    load-module module-switch-on-connect
  ";

  # FIXME: refactor to be able to move this to <root>/users
  environment.sessionVariables = {
    NODE_OPTIONS = "--max-old-space-size=4096";
  };

  services.tlp = {
    enable = true;
    extraConfig = ''
      CPU_SCALING_GOVERNOR_ON_AC=performance
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
    '';
  };

  swapDevices = [{ device = "/swapfile"; size = 8192; }];
}

