{ pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./displays.nix
    ];

  networking.hostName = "radoslawgrochowski-desktop";
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  swapDevices = [{ device = "/swapfile"; size = 8192; }];
  system.stateVersion = "23.05";
}

