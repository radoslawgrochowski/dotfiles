({ username, inputs, ... }: {
  # Auto upgrade nix package and the daemon service.
# FIXME: move to darwin  
#  services.nix-daemon.enable = true;

  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs-stable;
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ "@admin" "${username}" ];
    };
  # FIXME: move to darwin
  # gc = {
  #   user = "root";
  #   automatic = true;
  #   interval = { Weekday = 0; Hour = 2; Minute = 0; };
  #   options = "--delete-older-than 30d";
  # };
  };
})
