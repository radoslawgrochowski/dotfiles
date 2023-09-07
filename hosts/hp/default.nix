{ }:

{
  imports = [
    ./hardware-configuration.nix
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
      naturalScrolling = false;
    };
  };

  networking.hostName = "radoslawgrochowski-hp";
  services.tlp.enable = true;

  hardware.bluetooth.enable = true;
  hardware.pulseaudio.extraConfig = "
    load-module module-switch-on-connect
  ";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

