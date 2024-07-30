{ inputs, ... }:
{
  nixpkgsCustom = (import ./nixpkgs-custom.nix { inherit inputs; }).nixpkgsCustom;
  nixpkgsLocalNodePackages = (import ./nixpkgs-local-node-packages.nix { inherit inputs; }).nixpkgsLocalNodePackages;
}
