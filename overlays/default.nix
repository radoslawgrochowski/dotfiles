{ inputs, ... }:
{
  nixpkgsCustom = (import ./nixpkgs-custom.nix { inherit inputs; }).nixpkgsCustom;
  nixpkgsLocalVimPlugins =
    (import ./nixpkgs-local-vim-plugins.nix { inherit inputs; }).nixpkgsLocalVimPlugins;
}
