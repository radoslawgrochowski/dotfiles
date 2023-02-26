{ config, lib, pkgs, modulesPath, ... }:

{
  services.tlp.enable = true;
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
}

