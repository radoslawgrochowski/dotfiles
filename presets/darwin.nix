# Configuration common to all macOS systems
{ pkgs, inputs, outputs, username, ... }: {
  imports = [
    ./common.nix
    inputs.home-manager.darwinModules.home-manager
    ../modules/home-manager
    ../modules/aerospace
    ../modules/karabiner

    inputs.nix-index-database.darwinModules.nix-index
    { programs.nix-index-database.comma.enable = true; }
  ];

  users.users."${username}" = {
    name = username;
    home = "/Users/${username}/";
  };

  services.nix-daemon.enable = true;
  programs.nix-index.enable = true;
  programs.bash.enable = true;
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ bashInteractive zsh ];
  security.pam.enableSudoTouchIdAuth = true;
  system.configurationRevision = outputs.rev or outputs.dirtyRev or null;

  system.defaults = {
    "dock" = {
      autohide = true;
      autohide-delay = null;
    };
    NSGlobalDomain = {
      # Disable animations when opening and closing windows.
      NSAutomaticWindowAnimationsEnabled = false;

      # Accelerated playback when adjusting the window size.
      NSWindowResizeTime = 0.001;

      # Holding a keyboard key down will repeat that key continuously,
      # after a delay, until the key is released
      # https://stackoverflow.com/a/70911250
      ApplePressAndHoldEnabled = false;

      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
    };
  };

  nix = {
    # gc = {
    #   user = "root";
    #   automatic = true;
    #   interval = { Weekday = 0; Hour = 2; Minute = 0; };
    #   options = "--delete-older-than 30d";
    # };
  };
}
