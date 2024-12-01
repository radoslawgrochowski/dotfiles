({ username, inputs, ... }: {
  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "@admin" "${username}" ];
      substituters = [
        "https://cache.nixos.org"
        "https://radoslawgrochowski-dotfiles.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "radoslawgrochowski-dotfiles.cachix.org-1:H4HOTwe9bPc+P2z/RVW3E8yBN6MwzRA4Xhv9RDpVu8c="
      ];
    };
  };
})
