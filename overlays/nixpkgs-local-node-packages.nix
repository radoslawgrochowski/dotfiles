{ inputs, ... }:
{
  nixpkgsLocalNodePackages = final: _prev: {
    localNodePackages = import ./node-packages/default.nix (
      let
        system = final.stdenv.hostPlatform.system;
        pkgs = import inputs.nixpkgs { localSystem = system; };
        nodejs = pkgs.nodejs_22;
      in
      {
        inherit system pkgs nodejs;
      }
    );
  };
}
