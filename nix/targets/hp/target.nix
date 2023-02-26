{ config, lib, pkgs, modulesPath, ... }:

{
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      horizontalScrolling = true;
      naturalScrolling = false;
    };
  };

  networking.hostName = "radoslawgrochowski-hp";
  services.tlp.enable = true;

  hardware.bluetooth.enable = true;
  hardware.pulseaudio.extraConfig = "
    load-module module-switch-on-connect
  ";
}

