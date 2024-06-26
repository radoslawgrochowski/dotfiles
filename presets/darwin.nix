# Configuration common to all macOS systems
{ pkgs, inputs, outputs, username, ... }: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ../modules/home-manager.nix
    ../modules/homebrew.nix
    ../modules/aerospace
    ../modules/karabiner.nix
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
