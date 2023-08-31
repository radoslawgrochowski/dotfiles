{ config, lib, pkgs, modulesPath, ... }:

let
  MHz = x: x * 1000;
in
{
  imports = [
    ./hardware-configuration.nix
    ./wfhsetup.nix
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

  powerManagement.cpuFreqGovernor = null;
  swapDevices = [{ device = "/swapfile"; size = 8192; }];
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      scaling_min_freq = MHz 1000;
      governor = "performance";
      turbo = "auto";
    };
  };
}

