{ config, pkgs, username, inputs, ... }:

{
  imports = [
    ./modules/default.nix
  ];

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pl_PL.UTF-8";
      LC_IDENTIFICATION = "pl_PL.UTF-8";
      LC_MEASUREMENT = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
      LC_NAME = "pl_PL.UTF-8";
      LC_NUMERIC = "pl_PL.UTF-8";
      LC_PAPER = "pl_PL.UTF-8";
      LC_TELEPHONE = "pl_PL.UTF-8";
      LC_TIME = "pl_PL.UTF-8";
    };
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "pl";
    xkbVariant = "";

    desktopManager.xterm.enable = false;
    displayManager = {
      autoLogin = {
        enable = true;
        user = username;
      };
    };
  };

  # Audio
  hardware.pulseaudio.support32Bit = true;
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  nixpkgs.config.pulseaudio = true;

  services.getty.autologinUser = username;

  # Configure console keymap
  console.keyMap = "pl2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    localBinInPath = true;
    systemPackages = with pkgs; [
      grub2
      lsof
      os-prober
      vim
      wget
      wl-clipboard
    ];
  };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  hardware.enableRedistributableFirmware = true;
}
