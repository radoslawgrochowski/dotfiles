{ pkgs, inputs, outputs, ... }: {
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  networking.hostName = "macaron";
}

