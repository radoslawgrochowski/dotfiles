{ inputs, ... }:
{
  nixpkgsLocalNodePackages = final: _prev: {
    localNodePackages = import ./node-packages/default.nix
      (
        let
          system = final.system;
          pkgs = import inputs.nixpkgs { inherit system; };
          nodejs = pkgs.nodejs;
        in
        {
          inherit system pkgs nodejs;
        }
      );
  };
}
        
