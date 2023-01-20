{ config, lib, pkgs, modulesPath, ... }:

{
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      horizontalScrolling = true;
      naturalScrolling = true;
    };
  };

  networking.hostName = "radoslawgrochowski-dell";

}

