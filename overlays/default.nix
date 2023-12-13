{ inputs, ... }:
{
  nixpkgsCustom = (import ./nixpkgs-custom.nix { inherit inputs; }).nixpkgsCustom;
}
