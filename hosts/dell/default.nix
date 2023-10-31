{ config, lib, pkgs, modulesPath, ... }:

let
  MHz = x: x * 1000;
in
{
  imports = [
    ./hardware-configuration.nix
    ./wfhsetup.nix
  ];

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader.systemd-boot.enable = false;
    loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    loader.grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      devices = [ "nodev" ];
    };
  };

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

  swapDevices = [{ device = "/swapfile"; size = 8192; }];

  powerManagement.cpuFreqGovernor = "performance";
  powerManagement.cpufreq.min = MHz 2000;
  services.thermald.enable = true;

  # services.auto-cpufreq.enable = true;
  # services.auto-cpufreq.settings = {
  #   battery = {
  #     governor = "powersave";
  #     turbo = "never";
  #   };
  #   charger = {
  #     scaling_min_freq = MHz 1000;
  #     governor = "performance";
  #     turbo = "auto";
  #   };
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

