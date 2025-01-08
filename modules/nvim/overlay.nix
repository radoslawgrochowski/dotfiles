{ inputs }: final: prev:
let
  packages = (final.callPackage ./neovim.nix { });
in
{
  nvim-rg = packages.nvim-rg;
  nvim-luarc-json = packages.nvim-luarc-json;
}
