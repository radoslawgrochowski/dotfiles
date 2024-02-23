({ username, inputs, ... }: {
  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs-stable;
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ "@admin" "${username}" ];
    };
  };
})
