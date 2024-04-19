# This overlay, when applied to nixpkgs, adds the final neovim derivation to nixpkgs.
{ inputs }: final: prev:
{
  nvim-rg = (final.callPackage ./neovim.nix { }).nvim-rg;
}
